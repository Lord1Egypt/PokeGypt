-- PokeGypt Account Manager NPC
-- Lets players create accounts, create characters, change passwords,
-- and delete characters entirely in-game — no external tools needed.
--
-- Log in with account "1" / password "1" to reach this NPC,
-- OR any player can walk up in Pallet Town and say "hi".

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)    npcHandler:onCreatureAppear(cid)    end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

-- ── State machine ─────────────────────────────────────────────────────────────
local FLOW_NONE            = 0
local FLOW_CREATE_ACCOUNT  = 1
local FLOW_CREATE_CHAR     = 2
local FLOW_CHANGE_PASS     = 3
local FLOW_DELETE_CHAR     = 4

local playerState = {}   -- [cid] = { flow, step, data={} }

local function getState(cid)
    if not playerState[cid] then
        playerState[cid] = { flow = FLOW_NONE, step = 0, data = {} }
    end
    return playerState[cid]
end

local function resetState(cid)
    playerState[cid] = nil
end

-- ── Validation helpers ────────────────────────────────────────────────────────
local function isValidAccName(name)
    return #name >= 4 and #name <= 14 and name:match("^[%w_]+$") ~= nil
end

local function isValidCharName(name)
    if #name < 3 or #name > 14 then return false end
    if not name:match("^[A-Za-z][A-Za-z ]*$") then return false end
    if name:match("  ") then return false end
    return true
end

local function isValidPass(pass)
    return #pass >= 4 and #pass <= 20
end

-- ── Database helpers ──────────────────────────────────────────────────────────
local RESERVED_NAME = "Account Manager"

local function accountExists(name)
    local q = db.storeQuery("SELECT id FROM accounts WHERE name = " .. db.escapeString(name))
    if q ~= false then result.free(q) return true end
    return false
end

-- Returns account id on success, nil on failure
local function checkCredentials(accName, password)
    local q = db.storeQuery(
        "SELECT id FROM accounts WHERE name = " .. db.escapeString(accName) ..
        " AND password = " .. db.escapeString(sha1(password))
    )
    if q ~= false then
        local id = result.getNumber(q, "id")
        result.free(q)
        return id
    end
    return nil
end

local function characterExists(name)
    local q = db.storeQuery("SELECT id FROM players WHERE name = " .. db.escapeString(name))
    if q ~= false then result.free(q) return true end
    return false
end

local function doCreateAccount(name, password)
    return db.query(
        "INSERT INTO accounts (name, password, type, creation) VALUES (" ..
        db.escapeString(name) .. ", " ..
        db.escapeString(sha1(password)) .. ", 1, " .. os.time() .. ")"
    )
end

local function doCreateCharacter(accId, charName)
    return db.query(
        "INSERT INTO players (name, group_id, account_id, town_id, looktype, cap, sex, conditions) " ..
        "VALUES (" .. db.escapeString(charName) .. ", 1, " .. accId ..
        ", 42, 136, 400, 1, X'')"
    )
end

local function doChangePassword(accId, newPass)
    return db.query(
        "UPDATE accounts SET password = " .. db.escapeString(sha1(newPass)) ..
        " WHERE id = " .. accId
    )
end

local function doDeleteCharacter(accId, charName)
    return db.query(
        "DELETE FROM players WHERE account_id = " .. accId ..
        " AND name = " .. db.escapeString(charName) ..
        " AND name != " .. db.escapeString(RESERVED_NAME)
    )
end

-- ── Main conversation callback ─────────────────────────────────────────────────
local function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then return false end

    local state = getState(cid)
    local lmsg  = msg:lower()

    -- Always handle bye / cancel
    if msgcontains(lmsg, "bye") or msgcontains(lmsg, "cancel") then
        if state.flow ~= FLOW_NONE then
            selfSay("Alright, no changes made.", cid)
        end
        resetState(cid)
        npcHandler:releaseFocus(cid)
        return true
    end

    -- ── Top-level menu (no active flow) ───────────────────────────────────────
    if state.flow == FLOW_NONE then
        if msgcontains(lmsg, "create account") then
            state.flow = FLOW_CREATE_ACCOUNT
            state.step = 1
            selfSay("Choose a name for the new account (4-14 letters/numbers):", cid)

        elseif msgcontains(lmsg, "create character") then
            state.flow = FLOW_CREATE_CHAR
            state.step = 1
            selfSay("Enter the account name you want to add a character to:", cid)

        elseif msgcontains(lmsg, "change password") then
            state.flow = FLOW_CHANGE_PASS
            state.step = 1
            selfSay("Enter your account name:", cid)

        elseif msgcontains(lmsg, "delete character") then
            state.flow = FLOW_DELETE_CHAR
            state.step = 1
            selfSay("Enter your account name:", cid)

        else
            selfSay("I can help you with: {create account}, {create character}, {change password}, or {delete character}. Say 'bye' to leave.", cid)
        end
        return true
    end

    -- ── CREATE ACCOUNT ────────────────────────────────────────────────────────
    if state.flow == FLOW_CREATE_ACCOUNT then
        if state.step == 1 then
            -- collect account name
            if not isValidAccName(msg) then
                selfSay("Invalid name. Use 4-14 letters or numbers, no spaces. Try again:", cid)
                return true
            end
            if accountExists(msg) then
                selfSay("That account name is already taken. Choose a different name:", cid)
                return true
            end
            state.data.accName = msg
            state.step = 2
            selfSay("Choose a password for '" .. msg .. "' (4-20 characters):", cid)

        elseif state.step == 2 then
            -- collect password
            if not isValidPass(msg) then
                selfSay("Password must be 4-20 characters. Try again:", cid)
                return true
            end
            state.data.password = msg
            state.step = 3
            selfSay("Confirm the password:", cid)

        elseif state.step == 3 then
            -- confirm password
            if msg ~= state.data.password then
                selfSay("Passwords do not match. Enter the password again:", cid)
                state.step = 2
                state.data.password = nil
                return true
            end
            if doCreateAccount(state.data.accName, state.data.password) then
                selfSay("Account '" .. state.data.accName .. "' created! You can now log in with it.", cid)
            else
                selfSay("Something went wrong. Please try again.", cid)
            end
            resetState(cid)
            npcHandler:releaseFocus(cid)
        end
        return true
    end

    -- ── CREATE CHARACTER ──────────────────────────────────────────────────────
    if state.flow == FLOW_CREATE_CHAR then
        if state.step == 1 then
            state.data.accName = msg
            state.step = 2
            selfSay("Enter the password for account '" .. msg .. "':", cid)

        elseif state.step == 2 then
            local accId = checkCredentials(state.data.accName, msg)
            if not accId then
                selfSay("Wrong account name or password. Let's try again — enter your account name:", cid)
                state.step = 1
                state.data = {}
                return true
            end
            state.data.accId = accId
            state.step = 3
            selfSay("Choose a name for your character (3-14 letters):", cid)

        elseif state.step == 3 then
            if not isValidCharName(msg) then
                selfSay("Invalid name. Use 3-14 letters, first letter capitalised, no double spaces. Try again:", cid)
                return true
            end
            if msg == RESERVED_NAME then
                selfSay("That name is reserved. Choose another:", cid)
                return true
            end
            if characterExists(msg) then
                selfSay("That name is already taken. Choose another:", cid)
                return true
            end
            if doCreateCharacter(state.data.accId, msg) then
                selfSay("Character '" .. msg .. "' created in Pallet Town! Log in and enjoy.", cid)
            else
                selfSay("Something went wrong. Please try again.", cid)
            end
            resetState(cid)
            npcHandler:releaseFocus(cid)
        end
        return true
    end

    -- ── CHANGE PASSWORD ───────────────────────────────────────────────────────
    if state.flow == FLOW_CHANGE_PASS then
        if state.step == 1 then
            state.data.accName = msg
            state.step = 2
            selfSay("Enter your current password:", cid)

        elseif state.step == 2 then
            local accId = checkCredentials(state.data.accName, msg)
            if not accId then
                selfSay("Wrong account name or password. Let's try again — enter your account name:", cid)
                state.step = 1
                state.data = {}
                return true
            end
            state.data.accId = accId
            state.step = 3
            selfSay("Enter your new password (4-20 characters):", cid)

        elseif state.step == 3 then
            if not isValidPass(msg) then
                selfSay("Password must be 4-20 characters. Try again:", cid)
                return true
            end
            state.data.newPass = msg
            state.step = 4
            selfSay("Confirm the new password:", cid)

        elseif state.step == 4 then
            if msg ~= state.data.newPass then
                selfSay("Passwords do not match. Enter the new password again:", cid)
                state.step = 3
                state.data.newPass = nil
                return true
            end
            if doChangePassword(state.data.accId, state.data.newPass) then
                selfSay("Password changed successfully!", cid)
            else
                selfSay("Something went wrong. Please try again.", cid)
            end
            resetState(cid)
            npcHandler:releaseFocus(cid)
        end
        return true
    end

    -- ── DELETE CHARACTER ──────────────────────────────────────────────────────
    if state.flow == FLOW_DELETE_CHAR then
        if state.step == 1 then
            state.data.accName = msg
            state.step = 2
            selfSay("Enter your account password:", cid)

        elseif state.step == 2 then
            local accId = checkCredentials(state.data.accName, msg)
            if not accId then
                selfSay("Wrong account name or password. Let's try again — enter your account name:", cid)
                state.step = 1
                state.data = {}
                return true
            end
            state.data.accId = accId
            state.step = 3
            selfSay("Enter the name of the character you want to delete:", cid)

        elseif state.step == 3 then
            if msg == RESERVED_NAME then
                selfSay("That character cannot be deleted.", cid)
                return true
            end
            -- verify character belongs to this account
            local q = db.storeQuery(
                "SELECT id FROM players WHERE account_id = " .. state.data.accId ..
                " AND name = " .. db.escapeString(msg)
            )
            if q == false then
                selfSay("No character named '" .. msg .. "' found on your account. Try again:", cid)
                return true
            end
            result.free(q)
            state.data.charName = msg
            state.step = 4
            selfSay("Are you sure you want to permanently delete '" .. msg .. "'? Say 'yes' to confirm or 'no' to cancel.", cid)

        elseif state.step == 4 then
            if lmsg == "yes" then
                if doDeleteCharacter(state.data.accId, state.data.charName) then
                    selfSay("Character '" .. state.data.charName .. "' has been permanently deleted.", cid)
                else
                    selfSay("Something went wrong. Please try again.", cid)
                end
            else
                selfSay("Deletion cancelled. Your character is safe.", cid)
            end
            resetState(cid)
            npcHandler:releaseFocus(cid)
        end
        return true
    end

    return true
end

-- Reset state when focus is released (player walked away etc.)
local function onReleaseFocusCallback(cid)
    resetState(cid)
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setCallback(CALLBACK_ONRELEASEFOCUS, onReleaseFocusCallback)
npcHandler:addModule(FocusModule:new())

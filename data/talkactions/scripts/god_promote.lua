-- PokeGypt GOD tool: promote/demote a player's rank (group + account type)
-- Usage: /promote playerName, rank      where rank = player | tutor | gm | god
local RANKS = {
	["player"]     = {group = 1, account = ACCOUNT_TYPE_NORMAL,      label = "Player"},
	["tutor"]      = {group = 1, account = ACCOUNT_TYPE_TUTOR,       label = "Tutor"},
	["gm"]         = {group = 2, account = ACCOUNT_TYPE_GAMEMASTER,  label = "Gamemaster"},
	["gamemaster"] = {group = 2, account = ACCOUNT_TYPE_GAMEMASTER,  label = "Gamemaster"},
	["god"]        = {group = 3, account = ACCOUNT_TYPE_GOD,         label = "God"},
}

function onSay(player, words, param)
	if player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end

	local split = param:split(",")
	local target = Player(split[1] and split[1]:gsub("^%s+", ""):gsub("%s+$", "") or "")
	if target == nil then
		player:sendCancelMessage("A player with that name is not online.")
		return false
	end

	local rankName = split[2] and split[2]:gsub("^%s+", ""):gsub("%s+$", ""):lower() or ""
	local rank = RANKS[rankName]
	if rank == nil then
		player:sendCancelMessage("Usage: /promote playerName, rank  (player | tutor | gm | god)")
		return false
	end

	target:setGroup(Group(rank.group))
	target:setAccountType(rank.account)
	target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have been set to " .. rank.label .. " by " .. player:getName() .. ". Relog to apply fully.")
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, target:getName() .. " is now " .. rank.label .. ".")
	print("> [GOD] " .. player:getName() .. " set " .. target:getName() .. " to " .. rank.label)
	return false
end

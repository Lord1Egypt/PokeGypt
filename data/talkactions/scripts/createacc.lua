-- PokeGypt in-game account manager (GOD only)
-- Usage: /createacc accountName, password
-- Creates a new account in the SQLite database (password hashed with sha1).

local function strip(s)
	return (s:gsub("^%s+", ""):gsub("%s+$", ""))
end

function onSay(player, words, param)
	if player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end

	local sep = param:find(",")
	if not sep then
		player:sendCancelMessage("Usage: /createacc accountName, password")
		return false
	end

	local name = strip(param:sub(1, sep - 1))
	local password = strip(param:sub(sep + 1))
	if name == "" or password == "" then
		player:sendCancelMessage("Usage: /createacc accountName, password")
		return false
	end

	if name:len() > 32 then
		player:sendCancelMessage("Account name is too long (max 32 characters).")
		return false
	end

	local resultId = db.storeQuery("SELECT `id` FROM `accounts` WHERE `name` = " .. db.escapeString(name))
	if resultId ~= false then
		result.free(resultId)
		player:sendCancelMessage("An account with that name already exists.")
		return false
	end

	db.query("INSERT INTO `accounts` (`name`, `password`, `type`, `premdays`, `lastday`, `email`, `creation`) VALUES (" ..
		db.escapeString(name) .. ", " .. db.escapeString(sha1(password)) .. ", 1, 0, 0, '', " .. os.time() .. ")")

	player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Account '" .. name .. "' has been created successfully.")
	print("> [createacc] " .. player:getName() .. " created account: " .. name)
	return false
end

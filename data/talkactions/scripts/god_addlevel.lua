-- PokeGypt GOD tool: add levels
-- Usage: /addlevel playerName, levels
local function getExpForLevel(level)
	level = level - 1
	return ((50 * level * level * level) - (150 * level * level) + (400 * level)) / 3
end

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

	local levels = tonumber(split[2])
	if levels == nil or levels == 0 then
		player:sendCancelMessage("Usage: /addlevel playerName, levels")
		return false
	end

	local newLevel = target:getLevel() + levels
	if newLevel < 1 then
		newLevel = 1
	end

	target:addExperience(getExpForLevel(newLevel) - target:getExperience(), false)
	target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You are now level " .. target:getLevel() .. " (set by " .. player:getName() .. ").")
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, target:getName() .. " is now level " .. target:getLevel() .. ".")
	return false
end

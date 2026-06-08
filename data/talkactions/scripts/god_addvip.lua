-- PokeGypt GOD tool: add VIP (premium) days
-- Usage: /addvip playerName, days
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

	local days = tonumber(split[2])
	if days == nil or days == 0 then
		days = 30
	end

	target:addPremiumDays(days)
	target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You received " .. days .. " VIP days from " .. player:getName() .. ".")
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You gave " .. days .. " VIP days to " .. target:getName() .. ".")
	return false
end

-- PokeGypt GOD tool: give money
-- Usage: /addmoney playerName, amount
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

	local amount = tonumber(split[2])
	if amount == nil or amount <= 0 then
		player:sendCancelMessage("Usage: /addmoney playerName, amount")
		return false
	end

	target:addMoney(amount)
	target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You received " .. amount .. " gold from " .. player:getName() .. ".")
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You gave " .. amount .. " gold to " .. target:getName() .. ".")
	return false
end

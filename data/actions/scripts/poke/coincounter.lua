function onUse(player, item, fromPosition, target, toPosition, isHotkey)

	local msg = "Dinheiro em conta: " .. player:getBankBalance() .. "\nTokens: " .. player:getTokens()
	player:showTextDialog(item:getId(), msg)

	return true
end

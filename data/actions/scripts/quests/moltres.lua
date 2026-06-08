local playerPosition = {
	{x = 1130, y = 743, z = 7},
	{x = 1129, y = 743, z = 7},
	{x = 1128, y = 743, z = 7},
	{x = 1127, y = 743, z = 7}
}
local newPosition = {
	{x = 1129, y = 745, z = 8},
	{x = 1128, y = 745, z = 8},
	{x = 1127, y = 745, z = 8},
	{x = 1126, y = 745, z = 8}
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 1946 then
		local players = {}
		for _, position in ipairs(playerPosition) do
			local topPlayer = Tile(position):getTopCreature()
			if topPlayer == nil or not topPlayer:isPlayer() or topPlayer:getLevel() < quests.moltres.level then
				player:sendTextMessage(MESSAGE_STATUS_SMALL, Game.getReturnMessage(RETURNVALUE_NOTPOSSIBLE))
				return false
			end
			players[#players + 1] = topPlayer
		end

		for i, targetPlayer in ipairs(players) do
			Position(playerPosition[i]):sendMagicEffect(CONST_ME_POFF)
			targetPlayer:teleportTo(newPosition[i], false)
			targetPlayer:getPosition():sendMagicEffect(CONST_ME_ENERGYAREA)
		end
		item:transform(1945)
	elseif item.itemid == 1945 then
		item:transform(1946)
		player:sendTextMessage(MESSAGE_STATUS_SMALL, Game.getReturnMessage(RETURNVALUE_NOTPOSSIBLE))
	end
	return true
end

function onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end

	local creature = Player(param)
	if not creature then
		player:sendCancelMessage("A player with that name could not be found.")
		return false
	end

	local oldPosition = creature:getPosition()
	local newPosition = player:getPosition()--creature:getClosestFreePosition(player:getPosition(), false)
	if newPosition and newPosition.x == 0 then
		player:sendCancelMessage("You can not teleport " .. creature:getName() .. ".")
		return false
	elseif newPosition and creature:teleportTo(newPosition) then
		if not creature:isInGhostMode() then
			oldPosition:sendMagicEffect(CONST_ME_POFF)
			newPosition:sendMagicEffect(CONST_ME_TELEPORT)
		end
	end
	return false
end

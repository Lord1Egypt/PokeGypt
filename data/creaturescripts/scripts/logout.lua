function onLogout(player)
	local playerId = player:getId()
	if nextUseStaminaTime[playerId] ~= nil then
		nextUseStaminaTime[playerId] = nil
	end

--	if player:isOnFly() then
--		player:sendCancelMessage("Sorry, you can not logout while on fly.")
--		return false
--	end

--	if player:isOnRide() then
--		player:sendCancelMessage("Sorry, you can not logout while on ride.")
--		return false
--	end

--	if player:isOnSurf() then
		player:setStorageValue(storageLogoutSpeed, player:getSpeed())
--		player:sendCancelMessage("Sorry, you can not logout while on surf.")
--		return false
--	end

	
	
	if hasSummons(player) then
		local ball = player:getUsingBall()
		if ball then
			local ballId = ball:getId()
			local ballKey = getBallKey(ballId)
			if ballId == balls[ballKey].usedOff then
				ball:transform(balls[ballKey].usedOn)
			end
		end
		doRemoveSummon(playerId)
	end

	if player:getStorageValue(storageBike) > 0 then
		player:removeCondition(CONDITION_OUTFIT)
		player:changeSpeed(-player:getStorageValue(storageBike))
		player:setStorageValue(storageBike, -1)
	end

	if player:getStorageValue(storageArenaEvent) == 2 then
		local town = player:getTown()
		player:teleportTo(town:getTemplePosition())
		player:unregisterEvent("PrepareDeathArena")
		player:setStorageValue(storageArenaEvent, -1)
	end

	return true
end

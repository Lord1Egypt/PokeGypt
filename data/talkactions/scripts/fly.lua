local prohibitedItems = {}

function onSay(player, words)
	if words == "!up" and player:getStorageValue(storageDive) > 0 then
		local nextPosition = player:getPosition():moveUpstairs()
		local tile = Tile(nextPosition)
		if tile and isInArray(waterIds, tile:getGround():getId()) and hasSummons(player) and MonsterType(player:getSummon():getName()):isSurfable() > 0 then
			player:setStorageValue(storageDive, -1)
			player:removeCondition(CONDITION_OUTFIT)
			player:teleportTo(nextPosition, false)
		else
			player:sendCancelMessage("You need a surfable pokemon to go up.")
		end
		return true
	end

	if not player:isOnFly() then
		player:sendCancelMessage("You are not flying.")
		return false
	end
	local last = player:getStorageValue(storageDelay)
	local interval = 1 
	if last+interval > os.time() then
		player:sendCancelMessage(RETURNVALUE_YOUAREEXHAUSTED)
		return false
	end
 
	if words == "!up" then
		local ret = player:flyUp()
		if ret == false then
			player:sendCancelMessage("You can not fly up.")
		else
			player:activateFly()
			player:setStorageValue(storageDelay, os.time())
		end
	elseif words == "!down" then
		local ret = player:flyDown()
		if ret == false then
			player:sendCancelMessage("You can not fly down.")
		else
			player:deactivateFly()
			player:setStorageValue(storageDelay, os.time())
		end
	end
	return false
end

--function onSay(player, words, param)
--	if player:getStorageValue(storageFly) ~= 1 then return false end
--	local position = player:getPosition()
--	position.z = position.z - 1	
--	local destTile = Tile(position)
--	if not destTile then
--		Game.createTile(position)
--		Game.createItem(8426, 1, position)
--		player:teleportTo(position)
--	end	
--	position:createFlyFloor()
--	player:teleportTo(position)
--	player:flyUp()
--	return false
--end

local delay = 10*60
local availableCities = 59

function onSay(player, words, param)
	if param == "" then
		local msg = "Available cities: \n\n"
		for i = 1, availableCities do
			local town = Town(i)
			if town then
				msg = msg .. town:getName() .. "\n"
			end
		end
		player:showTextDialog(2263, msg)
		return false
	end

	if player:isPzLocked() then
		player:sendCancelMessage("Sorry, not possible while PZ locked.")
		return false		
	end

	local timeSinceLast = os.time() - player:getStorageValue(storageDelayTeleport)
	if timeSinceLast < delay then
		player:sendCancelMessage("Sorry, not possible. You need to wait " .. delay - timeSinceLast .. " seconds to teleport again.")
		return false		
	end

	if not hasSummons(player) then
		player:sendCancelMessage("Sorry, not possible. You need a pokemon to use teleport.")
		return false
	end

	local summon = player:getSummon()
	local summonName = summon:getName()
	local monsterType = MonsterType(summonName)
	if monsterType:canTeleport() == 0 then
		player:sendCancelMessage("Sorry, not possible. Your pokemon can not teleport.")
		return false		
	end

	local town = Town(param)
	if town == nil then
		town = Town(tonumber(param))
	end

	if town == nil then
		player:sendCancelMessage("Town not found.")
		return false
	end

	if town:getId() > availableCities then
		player:sendCancelMessage("Sorry, town not available.")
		return false
	end

	if town:getId() > 49 then
		if player:getStorageValue(quests.cathemAll.prizes[1].uid) < 2 then
			player:sendCancelMessage("Sorry, not possible. You must finish catch'em all quest before teleport to this city.")
			return false
		end
	end

	if player:isOnDive() then
		player:setStorageValue(storageDive, -1)
		player:removeCondition(CONDITION_OUTFIT)
	end

	if player:isDuelingWithNpc() then
		player:unsetDuelWithNpc()
	end

	player:say(summonName .. ", bring me to " .. town:getName() .. "!", TALKTYPE_SAY)
	player:teleportTo(town:getTemplePosition())
	player:setStorageValue(storageDelayTeleport, os.time())
	return false
end

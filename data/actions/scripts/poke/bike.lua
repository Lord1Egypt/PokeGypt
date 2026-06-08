local delay = 0.1
local bonusSpeed = 1.2
local outfitMale = 1315
local outfitFemale = 1316
local condition = Condition(CONDITION_OUTFIT)
condition:setTicks(-1)

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if os.time() > player:getStorageValue(storageDelay) then
	       	player:setStorageValue(storageDelay, os.time() + delay)
	else
		player:sendCancelMessage(RETURNVALUE_YOUAREEXHAUSTED)
		return true
	end

	if fromPosition.x ~= 65535 then
		player:sendCancelMessage("First pick up the bike.")
		return true
	end

	if player:getStorageValue(storageRide) == 1 then
		player:sendCancelMessage("Sorry, not possible while on ride.")
		return true
	end

	if player:getStorageValue(storageFly) == 1 then
		player:sendCancelMessage("Sorry, not possible while on fly.")
		return true
	end

	if player:getStorageValue(storageSurf) > 0 then
		player:sendCancelMessage("Sorry, not possible while on surf.")
		return true
	end

	if player:getStorageValue(storageDive) > 0 then
		player:sendCancelMessage("Sorry, not possible while on dive.")
		return true
	end

	if player:getStorageValue(storageEvent) > 0 then
		player:sendCancelMessage("Sorry, not possible while on event.")
		return true
	end

	if player:getStorageValue(storageBike) > 0 then
		player:removeCondition(CONDITION_OUTFIT)
		player:changeSpeed(player:getBaseSpeed()-player:getSpeed())
		player:setStorageValue(storageBike, -1)
	else
		local delta = player:getSpeed() * bonusSpeed
		if player:getSex() == PLAYERSEX_MALE then outfit = outfitMale else outfit = outfitFemale end
		condition:setOutfit({lookType = outfit})
		player:addCondition(condition)
		player:setStorageValue(storageBike, 1)
		player:changeSpeed(delta)
	end

	return true
end







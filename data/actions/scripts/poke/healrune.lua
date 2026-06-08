function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not target then
		return false
	end

	if type(target) ~= "userdata" then
		return true
	end

	if not target:isCreature() then
		return true
	end

	if not (target:isPokemon() or target:isPlayer()) then 
		return false 
	end

	if target:isPokemon() and target:getMaster():isDuelingWithNpc() then
		player:sendCancelMessage("Sorry, not possible while in duels.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return true
	end

	if player:isOnLeague() then
		if not player:canUsePotionOnLeague() then
			player:sendCancelMessage("Sorry, you can not use potion anymore.")
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
			return true
		end
	end

	local maxHealth = target:getMaxHealth()
	local heal = math.floor(maxHealth / 3)
	if player:getVocation():getName() == "Healer" then
		heal = math.floor(heal * healerHealBuff)
	end
	target:addHealth(heal)
	target:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	item:remove(1)
	return true
end

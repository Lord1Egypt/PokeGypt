function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not target then
		return false
	end

	if type(target) ~= "userdata" then
		return true
	end

	if target:isCreature() then
		return false
	end

	if target:isItem() and not target:isPokeball() then
		player:sendCancelMessage("Sorry, not possible. You can only use on pokeballs.")
		return true
	end

	local summonHealth = target:getSpecialAttribute("pokeHealth")
	local summonName = target:getSpecialAttribute("pokeName")

	if summonHealth > 0 then
		player:sendCancelMessage("Sorry, not possible. You can only use on fainted summons.")
		return true
	end

	if player:isDuelingWithNpc() then
		player:sendCancelMessage("Sorry, not possible while in duels.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return true
	end

	if player:isOnLeague() then
		if not player:canUseReviveOnLeague() then
			player:sendCancelMessage("Sorry, you can not use revive anymore.")
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
			return true
		end
	end

	target:setSpecialAttribute("pokeHealth", MonsterType(summonName):getHealth())
	local ballKey = getBallKey(target:getId())
	target:transform(balls[ballKey].usedOn)
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	item:remove(1)
	return true
end

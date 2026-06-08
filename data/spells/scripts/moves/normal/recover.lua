local effect = 351

function onCastSpell(creature, variant)
	local maximumHealth = creature:getTotalHealth()
	local min = maximumHealth * 2 / 8
	local max = maximumHealth * 7 / 8
	local heal = math.random(min, max)
	if creature:isPokemon() then
		if creature:getMaster():getVocation():getName() == "Healer" then
			heal = heal * healerHealBuff
		end
	end
	doTargetCombatHealth(0, creature, COMBAT_HEALING, heal, heal, effect)

	return true
end

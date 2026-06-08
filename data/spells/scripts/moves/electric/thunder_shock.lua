local damageMultiplier = damageMultiplierMoves.areawaves
local combat = COMBAT_ELECTRICDAMAGE
local areaDamage = createCombatArea(AREA_CIRCLE1X1)
local effect = 539

function onCastSpell(creature, variant)

	local damage = damageMultiplier * creature:getTotalMagicAttack()
	local playerPosition = creature:getPosition()
	local effectPosition = creature:getPosition()

	effectPosition:getNextPosition(1)
	effectPosition:getNextPosition(2)

	effectPosition:sendMagicEffect(effect)
	doAreaCombatHealth(creature.uid, combat, playerPosition, areaDamage, -damage, -damage, 0)

	return true
end

local damageMultiplier = damageMultiplierMoves.areawaves
local combat = COMBAT_FIGHTINGDAMAGE
local defenseType = COMBAT_PHYSICALDAMAGE
local effect = 544
local areaEffect = createCombatArea(NO_AREA)
local areaDamage = createCombatArea(AREA_CIRCLE1X1)

function onCastSpell(creature, variant)

	local damage = damageMultiplier * creature:getTotalMeleeAttack()
	local creaturePosition = creature:getPosition()
	local effectPosition = creature:getPosition()

	effectPosition:getNextPosition(1)
	effectPosition:getNextPosition(2)

	doAreaCombatHealth(creature.uid, combat, effectPosition, areaEffect, 0, 0, effect, defenseType)
	doAreaCombatHealth(creature.uid, combat, creaturePosition, areaDamage, -damage, -damage, 0, defenseType)
	return true
end

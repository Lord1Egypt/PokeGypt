local damageMultiplier = damageMultiplierMoves.singletarget
local effect = 756
local missile_effect = 41
local areaDamage = createCombatArea(AREA_CIRCLE1X1_2)
local areaEffect = createCombatArea(NO_AREA)
local combat = COMBAT_FIGHTINGDAMAGE
local defenseType = COMBAT_PHYSICALDAMAGE

function onCastSpell(creature, variant)
	local target = creature:getTarget()
	if not target then return true end

	local damage = damageMultiplier * creature:getTotalMeleeAttack()
	local creaturePosition = creature:getPosition()
	local targetPosition = target:getPosition()
	local effectPosition = target:getPosition()

	effectPosition:getNextPosition(1)
	effectPosition:getNextPosition(2)

	doSendDistanceShoot(creaturePosition, targetPosition, missile_effect)
	doAreaCombatHealth(creature.uid, combat, targetPosition, areaDamage, -damage, -damage, 0, defenseType)
	doAreaCombatHealth(creature.uid, combat, effectPosition, areaEffect, 0, 0, effect, defenseType)

	return true
end

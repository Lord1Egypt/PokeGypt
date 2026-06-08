local damageMultiplier = damageMultiplierMoves.areatarget
local missileEffect = 123
local effect = 470
local areaDamage = createCombatArea(AREA_CIRCLE2X2)
local areaEffect = createCombatArea(NO_AREA)
local combat = COMBAT_PSYCHICDAMAGE

function onCastSpell(creature, variant)
	local target = creature:getTarget()
	if not target then return true end

	local damage = damageMultiplier * creature:getTotalMagicAttack()
	local creaturePosition = creature:getPosition()
	local targetPosition = target:getPosition()
	local effectPosition = target:getPosition()
	effectPosition:getNextPosition(1)
	effectPosition:getNextPosition(2)

	doSendDistanceShoot(creaturePosition, targetPosition, missileEffect)
	doAreaCombatHealth(creature.uid, combat, effectPosition, areaEffect, 0, 0, effect)
	doAreaCombatHealth(creature.uid, combat, targetPosition, areaDamage, -damage, -damage, 0)

	return true
end

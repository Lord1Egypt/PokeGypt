local damageMultiplier = damageMultiplierMoves.singletargetstrong
local effect = 421
local healingEffect = 833
local missileEffect = 130
local area = createCombatArea(NO_AREA)
local combat = COMBAT_PSYCHICDAMAGE

function onCastSpell(creature, variant)
	local target = creature:getTarget()
	if not target then return true end

	local damage = damageMultiplier * creature:getTotalMagicAttack()
	local creaturePosition = creature:getPosition()
	local targetPosition = target:getPosition()

	local targetPositionEffect = target:getPosition()
	targetPositionEffect:getNextPosition(1)
	targetPositionEffect:getNextPosition(2)

	local creaturePositionEffect = creature:getPosition()
	creaturePositionEffect:getNextPosition(1)
	creaturePositionEffect:getNextPosition(2)

	doSendDistanceShoot(targetPosition, creaturePosition, missileEffect)
	doAreaCombatHealth(creature.uid, combat, targetPosition, area, -damage, -damage, 0)
	doAreaCombatHealth(creature.uid, combat, targetPositionEffect, area, 0, 0, effect)
	doAreaCombatHealth(creature.uid, combat, creaturePositionEffect, area, 0, 0, healingEffect)
	doTargetCombatHealth(0, creature, COMBAT_HEALING, damage, damage, 0)

	return true
end

-- should only work if target is asleep


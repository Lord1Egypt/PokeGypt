local damageMultiplier = damageMultiplierMoves.singletarget
local missileEffect = 111
local areaEffect = 431
local combat = COMBAT_ICEDAMAGE

function onCastSpell(creature, variant)
	local target = creature:getTarget()
	if not target then return true end

	local damage = damageMultiplier * creature:getTotalMagicAttack()
	local creaturePosition = creature:getPosition()
	local targetPosition = target:getPosition()

	doSendDistanceShoot(creaturePosition, targetPosition, missileEffect)
	doTargetCombatHealth(creature.uid, target, combat, -damage, -damage, areaEffect)

	return true
end

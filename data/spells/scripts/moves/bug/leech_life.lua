local damageMultiplier = damageMultiplierMoves.singletarget
local effect = 342
local healingEffect = CONST_ME_MAGIC_GREEN
local missileEffect = 122
local combat = COMBAT_BUGDAMAGE
local defenseType = COMBAT_PHYSICALDAMAGE

function onCastSpell(creature, variant)
	local target = creature:getTarget()
	if not target then return true end

	local damage = damageMultiplier * creature:getTotalMeleeAttack()
	local creaturePosition = creature:getPosition()
	local targetPosition = target:getPosition()

	doSendDistanceShoot(targetPosition, creaturePosition, missileEffect)
	doTargetCombatHealth(creature.uid, target, combat, -damage, -damage, 0, defenseType)
	doTargetCombatHealth(0, creature, COMBAT_HEALING, damage, damage, healingEffect)
	creaturePosition:sendMagicEffect(effect)

	return true
end


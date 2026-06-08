local damageMultiplier = damageMultiplierMoves.singletargetstrong
local effect = 48
local missile_effect = 123
local combat = COMBAT_PSYCHICDAMAGE
local defenseType = COMBAT_PHYSICALDAMAGE

function onCastSpell(creature, variant)
	local target = creature:getTarget()
	if not target then return true end

	local damage = damageMultiplier * creature:getTotalMeleeAttack()
	local creaturePosition = creature:getPosition()
	local targetPosition = target:getPosition()

	doSendDistanceShoot(creaturePosition, targetPosition, missile_effect)
	doTargetCombatHealth(creature.uid, target, combat, -damage, -damage, effect, defenseType)

	return true
end

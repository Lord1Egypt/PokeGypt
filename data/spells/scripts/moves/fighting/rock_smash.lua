local damageMultiplier = damageMultiplierMoves.singletarget
local effect = 231
local combat = COMBAT_FIGHTINGDAMAGE
local defenseType = COMBAT_PHYSICALDAMAGE

function onCastSpell(creature, variant)
	local target = creature:getTarget()
	if not target then return true end

	local damage = damageMultiplier * creature:getTotalMeleeAttack()
	local targetPosition = target:getPosition()

	doTargetCombatHealth(creature.uid, target, combat, -damage, -damage, effect, defenseType)

	return true
end

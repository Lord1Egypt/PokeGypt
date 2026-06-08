local damageMultiplier = damageMultiplierMoves.singletargetstrong
local effect = 345
local combat = COMBAT_PSYCHICDAMAGE

function onCastSpell(creature, variant)
	local target = creature:getTarget()
	if not target then return true end

	local damage = damageMultiplier * creature:getTotalMagicAttack()
	doTargetCombatHealth(creature.uid, target, combat, -damage, -damage, effect)

	return true
end

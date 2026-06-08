local damageMultiplier = damageMultiplierMoves.singletargetstrong
local areaEffect = 491
local combat = COMBAT_BUGDAMAGE

function onCastSpell(creature, variant)
	local target = creature:getTarget()
	if not target then return true end

	local damage = damageMultiplier * creature:getTotalMagicAttack()

	doTargetCombatHealth(creature.uid, target, combat, -damage, -damage, areaEffect)

	return true
end

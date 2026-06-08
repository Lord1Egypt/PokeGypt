local damageMultiplier = damageMultiplierMoves.singletargetweak
local areaEffect = 511
local combat = COMBAT_GROUNDDAMAGE

function onCastSpell(creature, variant)
	local target = creature:getTarget()
	if not target then return true end

	local damage = damageMultiplier * creature:getTotalMagicAttack()
	doTargetCombatHealth(creature.uid, target, combat, -damage, -damage, areaEffect)

	return true
end

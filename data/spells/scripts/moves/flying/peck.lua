local damageMultiplier = damageMultiplierMoves.singletarget
local areaEffect = 10
local combat = COMBAT_FLYINGDAMAGE

function onCastSpell(creature, variant)
	local target = creature:getTarget()
	if not target then return true end

	local damage = damageMultiplier * creature:getTotalMagicAttack()
	doTargetCombatHealth(creature.uid, target, combat, -damage, -damage, areaEffect)

	return true
end

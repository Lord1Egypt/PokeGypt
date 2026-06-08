local damageMultiplier = damageMultiplierMoves.singletargetstrong
local areaEffect = 663
local combat = COMBAT_WATERDAMAGE
local defenseType = COMBAT_PHYSICALDAMAGE

function onCastSpell(creature, variant)
	local target = creature:getTarget()
	if not target then return true end

	local damage = damageMultiplier * creature:getTotalMeleeAttack()
	doTargetCombatHealth(creature.uid, target, combat, -damage, -damage, areaEffect, defenseType)

	return true
end

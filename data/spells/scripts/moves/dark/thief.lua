local damageMultiplier = damageMultiplierMoves.singletarget
local effect = 617
local combat = COMBAT_DARKDAMAGE
local defenseType = COMBAT_PHYSICALDAMAGE

function onCastSpell(creature, variant)
	local target = creature:getTarget()
	if not target then return true end

	local damage = damageMultiplier * creature:getTotalMeleeAttack()
	doTargetCombatHealth(creature.uid, target, combat, -damage, -damage, effect, defenseType)

	return true
end

-- should increase droprate

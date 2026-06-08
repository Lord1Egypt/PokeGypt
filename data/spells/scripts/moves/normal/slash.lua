local damageMultiplier = damageMultiplierMoves.singletarget
local areaEffect = 634
local combat = COMBAT_NORMALDAMAGE
local defenseType = COMBAT_PHYSICALDAMAGE

function onCastSpell(creature, variant)
	local target = creature:getTarget()
	if not target then return true end

	local damage = damageMultiplier * creature:getTotalMeleeAttack()

	local effectPosition = target:getPosition()
	effectPosition:getNextPosition(1)
	effectPosition:getNextPosition(2)
	effectPosition:sendMagicEffect(areaEffect)
	doTargetCombatHealth(creature.uid, target, combat, -damage, -damage, 0, defenseType)

	return true
end

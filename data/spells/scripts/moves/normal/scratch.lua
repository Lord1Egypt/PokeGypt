local damageMultiplier = damageMultiplierMoves.singletargetweak
local areaEffect = 832
local area = createCombatArea(AREA_BEAM1)
local combat = COMBAT_NORMALDAMAGE
local defenseType = COMBAT_PHYSICALDAMAGE

function onCastSpell(creature, variant)
	local target = creature:getTarget()
	if not target then return true end

	local damage = damageMultiplier * creature:getTotalMeleeAttack()
	local targetPosition = target:getPosition()
	local effectPosition = target:getPosition()

	effectPosition:getNextPosition(1)
	effectPosition:getNextPosition(2)

	doAreaCombatHealth(creature.uid, combat, targetPosition, area, -damage, -damage, 0, defenseType)
	doAreaCombatHealth(creature.uid, combat, effectPosition, area, 0, 0, areaEffect, defenseType)

	return true
end

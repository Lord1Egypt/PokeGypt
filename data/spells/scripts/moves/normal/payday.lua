local damageMultiplier = damageMultiplierMoves.singletargetweak
local effect = 10
local area = createCombatArea(NO_AREA)
local combat = COMBAT_NORMALDAMAGE
local defenseType = COMBAT_PHYSICALDAMAGE

function onCastSpell(creature, variant)
	local target = creature:getTarget()
	if not target then return true end

	local damage = damageMultiplier * creature:getTotalMeleeAttack()
	local creaturePosition = creature:getPosition()
	local targetPosition = target:getPosition()
	local dir = creature:getDirection()
	doAreaCombatHealth(creature.uid, combat, targetPosition, area, -damage, -damage, effect, defenseType)

	return true
end

-- should increase droprate

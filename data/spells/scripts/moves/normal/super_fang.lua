local damageMultiplier = damageMultiplierMoves.singletarget
local missileEffect = 41
local areaEffect = 235
local area = createCombatArea(AREA_BEAM1)
local combat = COMBAT_NORMALDAMAGE
local defenseType = COMBAT_PHYSICALDAMAGE

function onCastSpell(creature, variant)
	local target = creature:getTarget()
	if not target then return true end

	local damage = damageMultiplier * creature:getTotalMeleeAttack()
	local creaturePosition = creature:getPosition()
	local targetPosition = target:getPosition()

	doSendDistanceShoot(creaturePosition, targetPosition, missileEffect)
	doAreaCombatHealth(creature.uid, combat, targetPosition, area, -damage, -damage, areaEffect, defenseType)

	return true
end

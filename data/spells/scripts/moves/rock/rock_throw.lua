local damageMultiplier = damageMultiplierMoves.singletarget
local missileEffect = 12
local areaEffect = 238
local area = createCombatArea(AREA_BEAM1)
local combat = COMBAT_ROCKDAMAGE
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

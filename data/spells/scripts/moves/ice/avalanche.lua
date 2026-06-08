local damageMultiplier = damageMultiplierMoves.areawaves
local missileEffect = 90
local areaEffect = 44
local area = createCombatArea(AREA_CIRCLE2X2)
local combat = COMBAT_ICEDAMAGE
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

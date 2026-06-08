local damageMultiplier = damageMultiplierMoves.areatarget
local missileEffect = 39
local areaEffect = 511
local area = createCombatArea(AREA_CIRCLE2X2)
local combat = COMBAT_GROUNDDAMAGE

function onCastSpell(creature, variant)
	local target = creature:getTarget()
	if not target then return true end

	local damage = damageMultiplier * creature:getTotalMagicAttack()
	local creaturePosition = creature:getPosition()
	local targetPosition = target:getPosition()

	doSendDistanceShoot(creaturePosition, targetPosition, missileEffect)
	doAreaCombatHealth(creature.uid, combat, targetPosition, area, -damage, -damage, areaEffect)

	return true
end

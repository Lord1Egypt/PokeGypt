local damageMultiplier = damageMultiplierMoves.singletargetweak
local missileEffect = 4
local areaEffect = 676
local area = createCombatArea(AREA_BEAM1)
local combat = COMBAT_FIREDAMAGE

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

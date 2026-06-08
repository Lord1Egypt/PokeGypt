local damageMultiplier = damageMultiplierMoves.singletargetstrong
local missileEffect = 114
local effect = 289
local areaDamage = createCombatArea(AREA_CIRCLE1X1_2)
local combat = COMBAT_POISONDAMAGE
local defenseType = COMBAT_PHYSICALDAMAGE

function onCastSpell(creature, variant)
	local target = creature:getTarget()
	if not target then return true end

	local damage = damageMultiplier * creature:getTotalMeleeAttack()
	local creaturePosition = creature:getPosition()
	local targetPosition = target:getPosition()
	local effectPosition = target:getPosition()

	effectPosition:getNextPosition(1)
	effectPosition:getNextPosition(2)

	doSendDistanceShoot(creaturePosition, targetPosition, missileEffect)
	doAreaCombatHealth(creature.uid, combat, targetPosition, areaDamage, -damage, -damage, 0, defenseType)
	effectPosition:sendMagicEffect(effect)

	return true
end

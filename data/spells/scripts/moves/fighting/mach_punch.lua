local damageMultiplier = damageMultiplierMoves.singletarget
local damageEffect = 767
local teleportEffect = 331
local areaDamage = createCombatArea(AREA_CIRCLE1X1)
local areaEffect = createCombatArea(NO_AREA)
local combat = COMBAT_FIGHTINGDAMAGE
local defenseType = COMBAT_PHYSICALDAMAGE

function onCastSpell(creature, variant)
	local target = creature:getTarget()
	if not target then return true end

	local damage = damageMultiplier * creature:getTotalMeleeAttack()

	local targetPosition = target:getPosition()
	local effectPosition = target:getPosition()
	effectPosition:getNextPosition(1)
	effectPosition:getNextPosition(2)
	effectPosition:sendMagicEffect(areaEffect)
	creature:getPosition():sendMagicEffect(teleportEffect)

	local random = math.random(0,3)
	targetPosition:getNextPosition(random)
	local newPos = creature:getClosestFreePosition(targetPosition, 0, true)
	newPos:sendMagicEffect(teleportEffect)
	creature:teleportTo(newPos)

	doAreaCombatHealth(creature.uid, combat, effectPosition, areaEffect, 0, 0, damageEffect, defenseType)
	doAreaCombatHealth(creature.uid, combat, targetPosition, areaDamage, -damage, -damage, 0, defenseType)
	return true
end

local damageMultiplier = damageMultiplierMoves.singletargetstrong
local damageEffect = 233
local teleportEffect = 331
local combat = COMBAT_FIGHTINGDAMAGE
local defenseType = COMBAT_PHYSICALDAMAGE

function onCastSpell(creature, variant)
	local target = creature:getTarget()
	if not target then return true end

	local damage = damageMultiplier * creature:getTotalMeleeAttack()

	local targetPosition = target:getPosition()
	creature:getPosition():sendMagicEffect(teleportEffect)
	local random = math.random(0,3)			
	targetPosition:getNextPosition(random)
	local newPos = creature:getClosestFreePosition(targetPosition, 0, true)
	newPos:sendMagicEffect(teleportEffect)
	creature:teleportTo(newPos)

	doTargetCombatHealth(creature.uid, target, combat, -damage, -damage, damageEffect, defenseType)
	return true
end

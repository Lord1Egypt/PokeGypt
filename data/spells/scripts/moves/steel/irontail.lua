local damageMultiplier = damageMultiplierMoves.singletarget
local damageEffect = 280
local combat = COMBAT_NORMALDAMAGE
local defenseType = COMBAT_PHYSICALDAMAGE

function onCastSpell(creature, variant)
	local target = creature:getTarget()
	if not target then return true end

	local damage = damageMultiplier * creature:getTotalMeleeAttack()

	local dir = creature:getDirection()
	if dir >= 2 then
		creature:setDirection(dir-2)
	else
		creature:setDirection(dir+2)
	end

	doTargetCombatHealth(creature.uid, target, combat, -damage, -damage, damageEffect, defenseType)
	return true
end

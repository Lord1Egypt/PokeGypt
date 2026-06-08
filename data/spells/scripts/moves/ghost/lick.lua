local damageMultiplier = damageMultiplierMoves.singletarget
local effect = 265
local combat = COMBAT_GHOSTDAMAGE
local defenseType = COMBAT_PHYSICALDAMAGE

local combatEvent = Combat()
combatEvent:setParameter(COMBAT_PARAM_EFFECT, 774)

local condition = Condition(CONDITION_PARALYZE)
condition:setParameter(CONDITION_PARAM_TICKS, 4000)
condition:setParameter(CONDITION_PARAM_SPEED, -50)
combatEvent:setCondition(condition)

function onCastSpell(creature, variant)
	local target = creature:getTarget()
	if not target then return true end

	local damage = damageMultiplier * creature:getTotalMeleeAttack()
	doTargetCombatHealth(creature.uid, target, combat, -damage, -damage, effect, defenseType)
	combatEvent:execute(creature, variant)

	return true
end


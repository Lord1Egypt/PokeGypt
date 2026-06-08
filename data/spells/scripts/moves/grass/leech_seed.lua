local time = 10000
local ticks = 2000
local effect = CONST_ME_SMALLPLANTS
local missileEffect = 60
local conditionType = CONDITION_SEED
local damageMultiplier = damageMultiplierMoves.singletarget/(time/ticks)

local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, effect)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, missileEffect)

function onTargetCreature(creature, target)
	if not target or target == creature then return false end

	local damage = damageMultiplier * creature:getTotalMagicAttack() 
	local condition = Condition(conditionType)
	condition:setParameter(CONDITION_PARAM_PERIODICDAMAGE, -damage)
	condition:setParameter(CONDITION_PARAM_TICKS, time)

	local conditionn = Condition(CONDITION_REGENERATION)
	conditionn:setParameter(CONDITION_PARAM_SUBID, 1)
	conditionn:setParameter(CONDITION_PARAM_TICKS, time)
	conditionn:setParameter(CONDITION_PARAM_HEALTHGAIN, damage)
	conditionn:setParameter(CONDITION_PARAM_HEALTHTICKS, ticks)
	conditionn:setParameter(CONDITION_PARAM_BUFF_SPELL, true)

	creature:addCondition(conditionn)
	target:addCondition(condition)
	
	return true
end

combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end



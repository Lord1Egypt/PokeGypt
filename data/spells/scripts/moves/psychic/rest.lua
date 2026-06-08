local ticks = 5000
local effect = 252

local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, effect)
combat:setParameter(CONDITION_PARAM_TICKS, ticks)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

local conditionParalyze = Condition(CONDITION_PARALYZE)
conditionParalyze:setParameter(CONDITION_PARAM_TICKS, ticks)
conditionParalyze:setParameter(CONDITION_PARAM_SPEED, -1000)
combat:setCondition(conditionParalyze)

local conditionRegeneration = Condition(CONDITION_REGENERATION)
conditionRegeneration:setParameter(CONDITION_PARAM_SUBID, 1)
conditionRegeneration:setParameter(CONDITION_PARAM_TICKS, ticks)
conditionRegeneration:setParameter(CONDITION_PARAM_BUFF_SPELL, true)

function onCastSpell(creature, variant)
	
	conditionRegeneration:setParameter(CONDITION_PARAM_HEALTHGAIN, creature:getTotalHealth()/(ticks/1000.0))
	combat:setCondition(conditionRegeneration)

	return combat:execute(creature, variant)
end

local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, 205)
combat:setArea(createCombatArea(AREA_CIRCLE3X3))

local condition = Condition(CONDITION_PARALYZE)

function onTargetCreature(creature, target)

	condition:setParameter(CONDITION_PARAM_TICKS, 5000)
	condition:setParameter(CONDITION_PARAM_SPEED, - 0.75 * target:getSpeed())
	target:addCondition(condition)
end

combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onCastSpell(creature, variant, isHotkey)

	if not combat:execute(creature, variant) then
		return false
	end

	return true
end

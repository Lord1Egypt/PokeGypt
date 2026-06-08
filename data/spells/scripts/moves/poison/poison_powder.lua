local time = 10000
local effect = 773
local damageMultiplier = damageMultiplierMoves.areawaves/(time/2000.0)
local conditionType = CONDITION_POISON

local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, effect)
combat:setArea(createCombatArea(AREA_CIRCLE3X3))

function onCastSpell(creature, variant, isHotkey)

	local damage = damageMultiplier * creature:getTotalMagicAttack()

	local condition = Condition(conditionType)
	condition:setParameter(CONDITION_PARAM_PERIODICDAMAGE, -damage)
	condition:setParameter(CONDITION_PARAM_TICKS, time)
	condition:setParameter(CONDITION_PARAM_SPEED, -1000)
	combat:setCondition(condition)

	if not combat:execute(creature, variant) then
		return false
	end

	return true
end

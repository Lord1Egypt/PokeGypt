local time = 500
local combat = COMBAT_PSYCHICDAMAGE

local area = {}
table.insert(area, createCombatArea(AREA_CIRCLE3X3))

local effect = {}
table.insert(effect, 253)

local damageMultiplier = damageMultiplierMoves.areatarget/#area

local combatEvent = Combat()
combatEvent:setArea(createCombatArea(AREA_CIRCLE3X3))

local condition = Condition(CONDITION_PARALYZE)
condition:setParameter(CONDITION_PARAM_TICKS, 5000)

function onTargetCreature(creature, target)

	condition:setParameter(CONDITION_PARAM_SPEED, - 0.5 * target:getSpeed())
	target:addCondition(condition)
end

combatEvent:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

local function spellCallback(uid, position, damage, count)
	local creature = Creature(uid)
	if creature then		
		if count <= #area then
			if not effect[count] then return true end
			doAreaCombatHealth(uid, combat, position, area[count], -damage, -damage, effect[count])
			count = count + 1			
			addEvent(spellCallback, time, uid, position, damage, count)
		end
	end
end

function onCastSpell(creature, variant)

	local damage = damageMultiplier * creature:getTotalMagicAttack()
	local position = creature:getPosition()

	if math.random(1, 100) <= 10 then
		combatEvent:execute(creature, variant)
	end

	spellCallback(creature.uid, position, damage, 1)

	return true
end

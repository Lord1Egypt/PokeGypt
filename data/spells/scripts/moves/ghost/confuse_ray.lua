local time = 1000
local hits = 10
local missileEffect = 104
local areaEffect = 598
local combat = COMBAT_NORMALDAMAGE

local combatEvent = Combat()
combatEvent:setParameter(COMBAT_PARAM_EFFECT, 774)
combatEvent:setParameter(COMBAT_PARAM_DISTANCEEFFECT, missileEffect)

local condition = Condition(CONDITION_DRUNK)

condition:setParameter(CONDITION_PARAM_TICKS, time * hits)
combatEvent:setCondition(condition)

local function spellCallback(uid, tuid, count)
	local creature = Creature(uid)
	local target = Creature(tuid)
	if creature and target then
		if count <= hits then
			local targetPosition = target:getPosition()

			targetPosition:sendMagicEffect(areaEffect) 

			count = count + 1
			addEvent(spellCallback, time, uid, tuid, count)
		end
	end
end

function onCastSpell(creature, variant)
	local target = creature:getTarget()
	if not target then return true end
	if target:isPlayer() and hasSummons(target) then return true end

	combatEvent:execute(creature, variant)

	spellCallback(creature.uid, target.uid, 1)
	return true
end

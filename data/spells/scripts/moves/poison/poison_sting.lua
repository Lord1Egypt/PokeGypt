local time = 10000
local damageMultiplier = damageMultiplierMoves.singletargetweak
local missileEffect = 74
local areaEffect = 422
local defenseType = COMBAT_PHYSICALDAMAGE
local combat = COMBAT_POISONDAMAGE
local randomNumber = math.random(1,100)

local combatEvent = Combat()
combatEvent:setParameter(COMBAT_PARAM_EFFECT, areaEffect)

function onCastSpell(creature, variant)
	local target = creature:getTarget()
	local creaturePosition = creature:getPosition()
	local targetPosition = target:getPosition()
	if not target then return true end
	if target:isPlayer() and hasSummons(target) then return true end

	local damage = damageMultiplier * creature:getTotalMeleeAttack()
	doSendDistanceShoot(creaturePosition, targetPosition, missileEffect)
	doTargetCombatHealth(creature.uid, target, combat, -damage, -damage, areaEffect, defenseType)


	if randomNumber <= 30 then  
        	local condition = Condition(CONDITION_POISON)
        	condition:setParameter(CONDITION_PARAM_PERIODICDAMAGE, -damage)
        	condition:setParameter(CONDITION_PARAM_TICKS, time)
        
        	target:addCondition(condition)
        
        	if not combatEvent:execute(creature, variant) then
        		return false
        	end
	end

	return true
end

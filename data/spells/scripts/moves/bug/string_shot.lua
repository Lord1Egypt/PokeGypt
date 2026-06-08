local damageMultiplier = damageMultiplierMoves.singletarget
local missileEffect = 80
local areaEffect = 257
local area = createCombatArea(AREA_BEAM1)
local combat = COMBAT_BUGDAMAGE

local combatEvent = Combat()
combatEvent:setParameter(COMBAT_PARAM_EFFECT, 774)

local condition = Condition(CONDITION_PARALYZE)
condition:setParameter(CONDITION_PARAM_TICKS, 4000)
condition:setParameter(CONDITION_PARAM_SPEED, -80)
combatEvent:setCondition(condition)

function onCastSpell(creature, variant)
	local target = creature:getTarget()
	if target:isPlayer() and hasSummons(target) then return true end

	local damage = damageMultiplier * creature:getTotalMagicAttack()
	local creaturePosition = creature:getPosition()
	local targetPosition = target:getPosition()

	doSendDistanceShoot(creaturePosition, targetPosition, missileEffect)
	doAreaCombatHealth(creature.uid, combat, targetPosition, area, -damage, -damage, areaEffect)

	combatEvent:execute(creature, variant)

	return true
end

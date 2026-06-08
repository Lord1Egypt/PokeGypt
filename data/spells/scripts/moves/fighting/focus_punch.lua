local damageMultiplier = damageMultiplierMoves.ultimate
local combat = COMBAT_FIGHTINGDAMAGE
local defenseType = COMBAT_PHYSICALDAMAGE
local area = createCombatArea(AREA_CIRCLE5X5)
local areaEffect = createCombatArea(AREA_5X5RANDOM)
local effect = 742

function onCastSpell(creature, variant)

	local damage = damageMultiplier * creature:getTotalMeleeAttack()
	local creaturePosition = creature:getPosition()
	local effectPosition = creature:getPosition()

	for i=1,2 do
		effectPosition:getNextPosition(1)
		effectPosition:getNextPosition(2)
	end

	doAreaCombatHealth(creature.uid, combat, effectPosition, areaEffect, 0, 0, effect, defenseType)
	doAreaCombatHealth(creature.uid, combat, creaturePosition, area, -damage, -damage, 0, defenseType)

	return true
end

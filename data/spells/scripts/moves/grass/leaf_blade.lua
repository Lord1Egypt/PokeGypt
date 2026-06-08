local damageMultiplier = damageMultiplierMoves.frontarea
local areaEffect = createCombatArea(NO_AREA)
local areaDamage = createCombatArea(FRONT_AREA_2)
local combat = COMBAT_GRASSDAMAGE
local defenseType = COMBAT_PHYSICALDAMAGE

local effects = {}
table.insert(effects, 650) --dir1
table.insert(effects, 647) --dir2
table.insert(effects, 649) --dir3
table.insert(effects, 648) --dir4

function onCastSpell(creature, variant)

	local damage = damageMultiplier * creature:getTotalMeleeAttack()
	local creaturePosition = creature:getPosition()
	local dir = creature:getDirection()
	local effectPosition = creature:getPosition()  

	creaturePosition:getNextPosition(dir)

	if dir == 0 or dir == 1 then
		effectPosition:getNextPosition(dir+1)
	else
		effectPosition:getNextPosition(dir-1)
	end
	if dir == 1 or dir == 2 then
		effectPosition:getNextPosition(dir)
		effectPosition:getNextPosition(dir)
	end
	
	doAreaCombatHealth(creature.uid, combat, effectPosition, areaEffect, 0, 0, effects[dir+1], defenseType)
	doAreaCombatHealth(creature.uid, combat, creaturePosition, areaDamage, -damage, -damage, 0, defenseType)

	return true
end

local damageMultiplier = damageMultiplierMoves.frontlinear
local areaEffect = createCombatArea(NO_AREA)
local areaDamage = createCombatArea(FRONT_AREA_2)
local combat = COMBAT_NORMALDAMAGE
local defenseType = COMBAT_PHYSICALDAMAGE

local effects = {}
table.insert(effects, 593) --dir1
table.insert(effects, 592) --dir2
table.insert(effects, 594) --dir3
table.insert(effects, 591) --dir4

function onCastSpell(creature, variant)

	local damage = damageMultiplier * creature:getTotalMeleeAttack()
	local creaturePosition = creature:getPosition()
	local dir = creature:getDirection()
	local effectPosition = creature:getPosition()  

	creaturePosition:getNextPosition(dir)
	effectPosition:getNextPosition(dir)

	if dir == 0 or dir == 1 then
		effectPosition:getNextPosition(dir+1)
		effectPosition:getNextPosition(dir+1)
	else
		effectPosition:getNextPosition(dir-1)
		effectPosition:getNextPosition(dir-1)
	end
	if dir == 1 or dir == 2 then
		effectPosition:getNextPosition(dir)
		effectPosition:getNextPosition(dir)
	end
	
	if creature then		
		doAreaCombatHealth(creature.uid, combat, effectPosition, areaEffect, 0, 0, effects[dir+1], defenseType)
		doAreaCombatHealth(creature.uid, combat, creaturePosition, areaDamage, -damage, -damage, 0, defenseType)
	end

	return true
end

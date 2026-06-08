local time = 100
local hits = 1
local damageMultiplier = damageMultiplierMoves.frontarea*(1+(hits-1)/4)/hits
local areaEffect = createCombatArea(NO_AREA)
local areaDamage = createCombatArea(AREATRIPLE_BEAM5)
local combat = COMBAT_WATERDAMAGE

local effects = {}
table.insert(effects, 554) --dir1
table.insert(effects, 551) --dir2
table.insert(effects, 553) --dir3
table.insert(effects, 552) --dir4

local function spellCallback(uid, position, creaturePosition, damage, count, dir)
	local creature = Creature(uid)
	if creature then		
		if count <= hits then			
			doAreaCombatHealth(uid, combat, position, areaEffect, 0, 0, effects[dir+1])
			doAreaCombatHealth(uid, combat, creaturePosition, areaDamage, -damage, -damage, 0)
			count = count + 1
			addEvent(spellCallback, time, uid, position, creaturePosition, damage, count, dir)
		end
	end
end

function onCastSpell(creature, variant)

	local damage = damageMultiplier * creature:getTotalMagicAttack()
	local positionEffect = creature:getPosition()
	local creaturePosition = creature:getPosition()
	local dir = creature:getDirection()

	positionEffect:getNextPosition(dir)
	creaturePosition:getNextPosition(dir)

	if dir == 0 or dir == 1 then
		positionEffect:getNextPosition(dir+1)
	else
		positionEffect:getNextPosition(dir-1)
	end
	if dir == 1 or dir == 2 then
		for i=1,4 do
			positionEffect:getNextPosition(dir)
		end
	end

	spellCallback(creature.uid, positionEffect, creaturePosition, damage, 1, dir)
	return true
end

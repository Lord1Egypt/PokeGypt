local time = 100
local hits = 1
local damageMultiplier = damageMultiplierMoves.frontlinear*(1+(hits-1)/4)/hits
local areaEffect = createCombatArea(NO_AREA)
local areaDamage = createCombatArea(AREATRIPLE_BEAM3)
local combat = COMBAT_FIGHTINGDAMAGE
local defenseType = COMBAT_PHYSICALDAMAGE

local effects = {}
table.insert(effects, 337) --dir1
table.insert(effects, 335) --dir2
table.insert(effects, 338) --dir3
table.insert(effects, 336) --dir4

local function spellCallback(uid, position, creaturePosition, damage, count, dir)
	local creature = Creature(uid)
	if creature then		
		if count <= hits then			
			doAreaCombatHealth(uid, combat, position, areaEffect, 0, 0, effects[dir+1], defenseType)
			doAreaCombatHealth(uid, combat, creaturePosition, areaDamage, -damage, -damage, 0, defenseType)
			count = count + 1
			addEvent(spellCallback, time, uid, position, creaturePosition, damage, count, dir)
		end
	end
end

function onCastSpell(creature, variant)

	local damage = damageMultiplier * creature:getTotalMeleeAttack()
	local position = creature:getPosition()
	local creaturePosition = creature:getPosition()
	local dir = creature:getDirection()
	position:getNextPosition(dir)
	creaturePosition:getNextPosition(dir)

	if dir == 1 or dir == 2 then
		for i = 1, 2 do
			position:getNextPosition(dir)
		end
	end

	spellCallback(creature.uid, position, creaturePosition, damage, 1, dir)
	return true
end

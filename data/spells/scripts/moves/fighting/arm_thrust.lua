local time = 100
local waves = 1
local damageMultiplier = damageMultiplierMoves.frontarea
local area = createCombatArea(AREA_BEAM1)
local areaDamage = createCombatArea(AREATRIPLE_BEAM3)
local combat = COMBAT_FIGHTINGDAMAGE
local defenseType = COMBAT_PHYSICALDAMAGE

local effects = {}
table.insert(effects, 337) --dir1
table.insert(effects, 335) --dir2
table.insert(effects, 338) --dir3
table.insert(effects, 336) --dir4

local function spellCallback(uid, position, positionDamage, damage, count, dir)
	local creature = Creature(uid)
	if creature then		
		if count <= waves then			
			doAreaCombatHealth(uid, combat, position, area, 0, 0, effects[dir+1], defenseType)
			doAreaCombatHealth(uid, combat, positionDamage, areaDamage, -damage, -damage, 0, defenseType)
			count = count + 1
			addEvent(spellCallback, time, uid, position, positionDamage, damage, count, dir)
		end
	end
end

function onCastSpell(creature, variant)

	local damage = damageMultiplier * creature:getTotalMeleeAttack()
	local position = creature:getPosition()
	local positionDamage = creature:getPosition()
	local dir = creature:getDirection()
	position:getNextPosition(dir)
	positionDamage:getNextPosition(dir)

	if dir == 1 or dir == 2 then
		for i=1,2 do
			position:getNextPosition(dir)
		end
	end

	spellCallback(creature.uid, position, positionDamage, damage, 1, dir)
	return true
end

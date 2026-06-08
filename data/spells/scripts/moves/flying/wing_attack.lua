local time = 100
local waves = 1
local damageMultiplier = damageMultiplierMoves.frontlinear/waves
local area = createCombatArea(AREA_BEAM1)
local areaDamage = createCombatArea(AREATRIPLE_BEAM1)
local defenseType = COMBAT_PHYSICALDAMAGE

local effects = {}
table.insert(effects, 248) --dir1
table.insert(effects, 249) --dir2
table.insert(effects, 251) --dir3
table.insert(effects, 250) --dir4

local function spellCallback(uid, position, positionDamage, damage, count, dir)
	local creature = Creature(uid)
	if creature then		
		if count <= waves then			
			doAreaCombatHealth(uid, COMBAT_FLYINGDAMAGE, position, area, 0, 0, effects[dir+1], defenseType)
			doAreaCombatHealth(uid, COMBAT_FLYINGDAMAGE, positionDamage, areaDamage, -damage, -damage, 0, defenseType)
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
	if dir == 0 or dir == 1 then
		position:getNextPosition(dir+1)
	else
		position:getNextPosition(dir-1)
	end
--	if dir == 1 or dir == 2 then
--		position:getNextPosition(dir)
--	end

	spellCallback(creature.uid, position, positionDamage, damage, 1, dir)
	return true
end

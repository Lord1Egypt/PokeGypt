local time = 100
local waves = 1
local damageMultiplier = damageMultiplierMoves.frontarea/waves
local area = createCombatArea(AREA_BEAM1)
local areaDamage = createCombatArea(AREATRIPLE_BEAM7)

local effects = {}
table.insert(effects, 584) --dir1
table.insert(effects, 583) --dir2
table.insert(effects, 584) --dir3
table.insert(effects, 583) --dir4

local function spellCallback(uid, position, positionDamage, damage, count, dir)
	local creature = Creature(uid)
	if creature then		
		if count <= waves then			
			doAreaCombatHealth(uid, COMBAT_ICEDAMAGE, position, area, 0, 0, effects[dir+1])
			doAreaCombatHealth(uid, COMBAT_ICEDAMAGE, positionDamage, areaDamage, -damage, -damage, 0)
			count = count + 1
			addEvent(spellCallback, time, uid, position, positionDamage, damage, count, dir)
		end
	end
end

function onCastSpell(creature, variant)

	local damage = damageMultiplier * creature:getTotalMagicAttack()
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
	if dir == 1 or dir == 2 then
		for i=1,5 do
			position:getNextPosition(dir)
		end
	end

	spellCallback(creature.uid, position, positionDamage, damage, 1, dir)
	return true
end

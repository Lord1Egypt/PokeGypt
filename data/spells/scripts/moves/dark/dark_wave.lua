local time = 100
local area = {}
table.insert(area, createCombatArea(AREA_WAVE4)) --dir1
table.insert(area, createCombatArea(AREA_WAVE4)) --dir2
table.insert(area, createCombatArea(AREA_WAVE4)) --dir3
table.insert(area, createCombatArea(AREA_WAVE4)) --dir4

local effects = {}
table.insert(effects, 607) --dir1
table.insert(effects, 607) --dir2
table.insert(effects, 607) --dir3
table.insert(effects, 607) --dir4

local damageMultiplier = damageMultiplierMoves.frontarea/#area

local function spellCallback(uid, position, damage, count, dir)
	local creature = Creature(uid)
	if creature then		
		if count <= #area then			
			doAreaCombatHealth(uid, COMBAT_DARKDAMAGE, position, area[dir+1], -damage, -damage, effects[dir+1])
			count = count + 1
			addEvent(spellCallback, time, uid, position, damage, count, dir)
		end
	end
end

function onCastSpell(creature, variant)

	local damage = damageMultiplier * creature:getTotalMagicAttack()
	local position = creature:getPosition()
	local dir = creature:getDirection()
	position:getNextPosition(dir)

	spellCallback(creature.uid, position, damage, 1, dir)
	return true
end

local time = 50
local area = {}
table.insert(area, createCombatArea(AREA_DRAGONWAVE)) --dir1
table.insert(area, createCombatArea(AREA_DRAGONWAVE)) --dir2
table.insert(area, createCombatArea(AREA_DRAGONWAVE)) --dir3
table.insert(area, createCombatArea(AREA_DRAGONWAVE)) --dir4

local effects = {}
table.insert(effects, 878) --dir1
table.insert(effects, 878) --dir2
table.insert(effects, 878) --dir3
table.insert(effects, 878) --dir4

local damageMultiplier = damageMultiplierMoves.frontarea/#area

local function spellCallback(uid, position, damage, count, dir)
	local creature = Creature(uid)
	if creature then		
		if count <= #area then			
			doAreaCombatHealth(uid, COMBAT_DRAGONDAMAGE, position, area[dir+1], -damage, -damage, effects[dir+1])
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

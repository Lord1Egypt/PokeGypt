local time = 1000
local waves = 1
local damageMultiplier = damageMultiplierMoves.frontlinear/waves
local area = createCombatArea(AREA_BEAM1) --area efeito
local areaDamage = createCombatArea(AREA_BEAM6) --area damage
local combat = COMBAT_WATERDAMAGE

local effects = {}
table.insert(effects, 194) --dir1
table.insert(effects, 189) --dir2
table.insert(effects, 197) --dir3
table.insert(effects, 192) --dir4

local effects2 = {}
table.insert(effects2, 195) --dir1
table.insert(effects2, 190) --dir2
table.insert(effects2, 195) --dir3
table.insert(effects2, 190) --dir4

local effects3 = {}
table.insert(effects3, 195) --dir1
table.insert(effects3, 190) --dir2
table.insert(effects3, 195) --dir3
table.insert(effects3, 190) --dir4

local effects4 = {}
table.insert(effects4, 195) --dir1
table.insert(effects4, 190) --dir2
table.insert(effects4, 195) --dir3
table.insert(effects4, 190) --dir4

local effects5 = {}
table.insert(effects5, 195) --dir1
table.insert(effects5, 190) --dir2
table.insert(effects5, 195) --dir3
table.insert(effects5, 190) --dir4

local effects6 = {}
table.insert(effects6, 196) --dir1
table.insert(effects6, 191) --dir2
table.insert(effects6, 198) --dir3
table.insert(effects6, 193) --dir4

local function spellCallback(uid, position, position2, position3, position4, position5, position6, positionDamage, damage, count, dir)
	local creature = Creature(uid)
	if creature then		
		if count <= waves then
			doAreaCombatHealth(uid, combat, position, area, 0, 0, effects[dir+1])
			doAreaCombatHealth(uid, combat, position2, area, 0, 0, effects2[dir+1])
			doAreaCombatHealth(uid, combat, position3, area, 0, 0, effects3[dir+1])
			doAreaCombatHealth(uid, combat, position4, area, 0, 0, effects4[dir+1])
			doAreaCombatHealth(uid, combat, position5, area, 0, 0, effects5[dir+1])
			doAreaCombatHealth(uid, combat, position6, area, 0, 0, effects6[dir+1])
                        doAreaCombatHealth(uid, combat, positionDamage, areaDamage, -damage, -damage, 0)
			count = count + 1
			addEvent(spellCallback, time, uid, position, position2, position3, position4, position5, position6, positionDamage, damage, count, dir)
		end
	end
end

function onCastSpell(creature, variant)

	local damage = damageMultiplier * creature:getTotalMagicAttack()
	local position = creature:getPosition()
	local position2 = creature:getPosition()
	local position3 = creature:getPosition()
	local position4 = creature:getPosition()
	local position5 = creature:getPosition()
	local position6 = creature:getPosition()
        local positionDamage = creature:getPosition()
	local dir = creature:getDirection()
	position:getNextPosition(dir)
	position2:getNextPosition(dir)
	position3:getNextPosition(dir)
	position4:getNextPosition(dir)
	position5:getNextPosition(dir)
	position6:getNextPosition(dir)
        positionDamage:getNextPosition(dir)

	if dir == 2 then
		position2.y = position2.y + 1
		position3.y = position3.y + 2
                position4.y = position4.y + 3
		position5.y = position5.y + 4
		position6.y = position6.y + 5
	elseif dir == 0 then
		position2.y = position2.y - 1
		position3.y = position3.y - 2
		position4.y = position4.y - 3
		position5.y = position5.y - 4
		position6.y = position6.y - 5                
	elseif dir == 1 then
		position2.x = position2.x + 1
		position3.x = position3.x + 2
                position4.x = position4.x + 3
		position5.x = position5.x + 4
		position6.x = position6.x + 5
	else
		position2.x = position2.x - 1
		position3.x = position3.x - 2
		position4.x = position4.x - 3
		position5.x = position5.x - 4
		position6.x = position6.x - 5                
	end

	spellCallback(creature.uid, position, position2, position3, position4, position5, position6, positionDamage, damage, 1, dir)
	return true
end

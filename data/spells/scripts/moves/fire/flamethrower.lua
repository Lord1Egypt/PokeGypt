local time = 100
local waves = 1
local spellDamageBonus = damageMultiplierMoves.frontarea/waves
local area = createCombatArea(AREA_BEAM1)
local areaDamage = createCombatArea(AREA_SQUAREWAVE3)

local effects = {}
table.insert(effects, 176) --dir1 -- cima
table.insert(effects, 179) --dir2 -- direita
table.insert(effects, 177) --dir3 -- baixo 
table.insert(effects, 178) --dir4 -- esquerda

local function spellCallback(uid, position, positionDamage, damage, count, dir)
	local creature = Creature(uid)
	if creature then		
		if count <= waves then			
			doAreaCombatHealth(uid, COMBAT_FIREDAMAGE, position, area, 0, 0, effects[dir+1])
			doAreaCombatHealth(uid, COMBAT_FIREDAMAGE, positionDamage, areaDamage, -damage, -damage, 0)
			count = count + 1
			addEvent(spellCallback, time, uid, position, positionDamage, damage, count, dir)
		end
	end
end

function onCastSpell(creature, variant)

	local damage = spellDamageBonus * creature:getTotalMagicAttack()
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
		position:getNextPosition(dir)
		position:getNextPosition(dir)
	end

	spellCallback(creature.uid, position, positionDamage, damage, 1, dir)
	return true
end

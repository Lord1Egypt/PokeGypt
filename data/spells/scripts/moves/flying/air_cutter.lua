local sqm = 5
local time = 300
local damageMultiplier = damageMultiplierMoves.frontarea
local areaEffect = createCombatArea(NO_AREA)
local areaDamage = createCombatArea(FRONT_AREA_2)
local combat = COMBAT_FLYINGDAMAGE

local effects = {}
table.insert(effects, 248) --dir1 -- cima
table.insert(effects, 249) --dir2 -- direita
table.insert(effects, 251) --dir3 -- baixo
table.insert(effects, 250) --dir4 -- esquerda

local function spellCallback(uid, position, positionEffect, damage, count, dir)
	local creature = Creature(uid)
	if creature then		
		if count <= sqm then
			doAreaCombatHealth(uid, combat, positionEffect, areaEffect, 0, 0, effects[dir+1])
			doAreaCombatHealth(uid, combat, position, areaDamage, -damage, -damage, 0)
			position:getNextPosition(dir)
			positionEffect:getNextPosition(dir)
			count = count + 1
			addEvent(spellCallback, time, uid, position, positionEffect, damage, count, dir)
		end
	end
end

function onCastSpell(creature, variant)

	local damage = damageMultiplier * creature:getTotalMagicAttack()
	local position = creature:getPosition()
	local dir = creature:getDirection()
	local positionEffect = creature:getPosition()

	position:getNextPosition(dir)
	positionEffect:getNextPosition(dir)
	if dir == 0 or dir == 1 then
		positionEffect:getNextPosition(dir+1)
	else
		positionEffect:getNextPosition(dir-1)
	end
	if dir == 1 or dir == 2 then
		positionEffect:getNextPosition(dir)
	end

	spellCallback(creature.uid, position, positionEffect, damage, 1, dir)
	return true
end

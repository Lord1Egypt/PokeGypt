local sqm = 5
local time = 150
local damageMultiplier = damageMultiplierMoves.frontlinear
local areaEffect = createCombatArea(NO_AREA)
local areaDamage = createCombatArea(FRONT_AREA_2)
local combat = COMBAT_PSYCHICDAMAGE

local effects = {}
table.insert(effects, 727) --dir1 -- cima
table.insert(effects, 727) --dir2 -- direita
table.insert(effects, 727) --dir3 -- baixo
table.insert(effects, 727) --dir4 -- esquerda

local function spellCallback(uid, position, positionEffect, damage, count, dir)
	local creature = Creature(uid)
	if creature then		
		if count <= sqm then
			doAreaCombatHealth(uid, combat, positionEffect, areaEffect , 0, 0, effects[dir+1])
			doAreaCombatHealth(uid, combat, position, areaDamage , -damage, -damage, 0)
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

	positionEffect:getNextPosition(dir)
	position:getNextPosition(dir)
	if dir == 0 then
		positionEffect:getNextPosition(dir+1)
	end
	if dir == 1 then
		positionEffect:getNextPosition(dir)
	end
	if dir == 2 then
		positionEffect:getNextPosition(dir-1)
	end
	if dir == 3 then
		positionEffect:getNextPosition(dir-2)
	end

	spellCallback(creature.uid, position, positionEffect, damage, 1, dir)
	return true
end

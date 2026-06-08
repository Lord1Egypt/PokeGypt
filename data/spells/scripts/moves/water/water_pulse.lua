local sqm = 5
local time = 150
local damageMultiplier = damageMultiplierMoves.frontarea
local area = createCombatArea(FRONT_AREA_2)
local combat = COMBAT_WATERDAMAGE

local effects = {}
table.insert(effects, 184) --dir1 -- cima
table.insert(effects, 185) --dir2 -- direita
table.insert(effects, 186) --dir3 -- baixo
table.insert(effects, 187) --dir4 -- esquerda

local function spellCallback(uid, position, positionEffect, damage, count, dir)
	local creature = Creature(uid)
	if creature then		
		if count <= sqm then
			positionEffect:sendMagicEffect(effects[dir+1])
			doAreaCombatHealth(uid, combat, position, area, -damage, -damage, 0)
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
	local positionEffect = creature:getPosition()
	local dir = creature:getDirection()

	position:getNextPosition(dir)
	positionEffect:getNextPosition(dir)

	spellCallback(creature.uid, position, positionEffect, damage, 1, dir)
	return true
end

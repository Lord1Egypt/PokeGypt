local sqm = 5
local time = 150
local damageMultiplier = damageMultiplierMoves.frontlinear
local areaEffect = createCombatArea(NO_AREA)
local areaDamage = createCombatArea(FRONT_AREA_2)
local combat = COMBAT_STEELDAMAGE
local defenseType = COMBAT_PHYSICALDAMAGE

local effects = {}
table.insert(effects, 382) --dir1 -- cima
table.insert(effects, 382) --dir2 -- direita
table.insert(effects, 382) --dir3 -- baixo
table.insert(effects, 382) --dir4 -- esquerda

local function spellCallback(uid, position, positionEffect, damage, count, dir)
	local creature = Creature(uid)
	if creature then		
		if count <= sqm then
			doAreaCombatHealth(uid, combat, positionEffect, areaEffect , 0, 0, effects[dir+1], defenseType)
			doAreaCombatHealth(uid, combat, position, areaDamage , -damage, -damage, 0, defenseType)
			position:getNextPosition(dir)
			positionEffect:getNextPosition(dir)
			count = count + 1
			addEvent(spellCallback, time, uid, position, positionEffect, damage, count, dir)
		end
	end
end

function onCastSpell(creature, variant)

	local damage = damageMultiplier * creature:getTotalMeleeAttack()
	local position = creature:getPosition()
	local dir = creature:getDirection()
	local positionEffect = creature:getPosition()

	position:getNextPosition(dir)
	positionEffect:getNextPosition(dir)

	spellCallback(creature.uid, position, positionEffect, damage, 1, dir)
	return true
end

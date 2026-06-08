local sqm = 5
local time = 150
local damageMultiplier = damageMultiplierMoves.frontlinear
local areaDamage = createCombatArea(FRONT_AREA_2)
local areaEffect = createCombatArea(NO_AREA)
local combat = COMBAT_FIREDAMAGE

local effects = {}
table.insert(effects, 400) --dir1 -- cima
table.insert(effects, 400) --dir2 -- direita
table.insert(effects, 400) --dir3 -- baixo
table.insert(effects, 400) --dir4 -- esquerda

local function spellCallback(uid, position, damage, count, dir)
	local creature = Creature(uid)
	if creature then		
		if count <= sqm then
			position:getNextPosition(dir)
			doAreaCombatHealth(uid, combat, position, areaDamage, -damage, -damage, 0)
			doAreaCombatHealth(uid, combat, position, areaEffect, 0, 0, effects[dir+1])
			count = count + 1
			addEvent(spellCallback, time, uid, position, damage, count, dir)
		end
	end
end

function onCastSpell(creature, variant)

	local damage = damageMultiplier * creature:getTotalMagicAttack()
	local position = creature:getPosition()
	local dir = creature:getDirection()

	spellCallback(creature.uid, position, damage, 1, dir)
	return true
end


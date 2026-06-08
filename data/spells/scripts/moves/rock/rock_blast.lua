local sqm = 5
local time = 150
local damageMultiplier = damageMultiplierMoves.frontlinear
local areaEffect = createCombatArea(NO_AREA)
local areaDamage = createCombatArea(FRONT_AREA_2)
local combat = COMBAT_ROCKDAMAGE
local defenseType = COMBAT_PHYSICALDAMAGE

local effects = {}
table.insert(effects, 349) --dir1 -- cima
table.insert(effects, 349) --dir2 -- direita
table.insert(effects, 349) --dir3 -- baixo
table.insert(effects, 349) --dir4 -- esquerda

local function spellCallback(uid, position, positionEff, damage, count, dir)
	local creature = Creature(uid)
	if creature then		
		if count <= sqm then
			positionEff:sendMagicEffect(effects[dir+1])
			doAreaCombatHealth(uid, combat, position, areaDamage , -damage, -damage, 0, defenseType)
			position:getNextPosition(dir)
			positionEff:getNextPosition(dir)
			count = count + 1
			addEvent(spellCallback, time, uid, position, positionEff, damage, count, dir)
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
	if dir == 1 then
		positionEffect:getNextPosition(dir)
		positionEffect:getNextPosition(dir+1)
	elseif dir == 2 then
		positionEffect:getNextPosition(dir)
		positionEffect:getNextPosition(dir)
	elseif dir == 3 then
		positionEffect:getNextPosition(dir-1)
	end

	spellCallback(creature.uid, position, positionEffect, damage, 1, dir)
	return true
end

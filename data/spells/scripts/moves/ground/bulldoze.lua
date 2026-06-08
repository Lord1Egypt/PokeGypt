local sqm = 5
local time = 150
local damageMultiplier = damageMultiplierMoves.frontlinear
local areaDamage = createCombatArea(FRONT_AREA_2)
local combat = COMBAT_GROUNDDAMAGE
local defenseType = COMBAT_PHYSICALDAMAGE

local effects = {}
table.insert(effects, 778) --dir1 -- cima
table.insert(effects, 776) --dir2 -- direita
table.insert(effects, 777) --dir3 -- baixo
table.insert(effects, 775) --dir4 -- esquerda

local function spellCallback(uid, position, effectPosition, damage, count, dir)
	local creature = Creature(uid)
	if creature then		
		if count <= sqm then
			effectPosition:sendMagicEffect(effects[dir+1])
			doAreaCombatHealth(uid, combat, position, areaDamage , -damage, -damage, 0, defenseType)
			position:getNextPosition(dir)
			effectPosition:getNextPosition(dir)
			count = count + 1
			addEvent(spellCallback, time, uid, position, effectPosition, damage, count, dir)
		end
	end
end

function onCastSpell(creature, variant)

	local damage = damageMultiplier * creature:getTotalMeleeAttack()
	local damagePosition = creature:getPosition()
	local dir = creature:getDirection()
	local effectPosition = creature:getPosition()

	damagePosition:getNextPosition(dir)
	effectPosition:getNextPosition(dir)
	if dir == 0 or dir == 1 then
		effectPosition:getNextPosition(dir+1)
	else
		effectPosition:getNextPosition(dir-1)
	end
	if dir == 1 or dir == 2 then
		effectPosition:getNextPosition(dir)
		effectPosition:getNextPosition(dir)
	end

	spellCallback(creature.uid, damagePosition, effectPosition, damage, 1, dir)
	return true
end

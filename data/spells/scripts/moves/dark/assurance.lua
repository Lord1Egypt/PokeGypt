local sqm = 5
local time = 50
local damageMultiplier = damageMultiplierMoves.frontlinear
local area = createCombatArea(AREA_BEAM1)
local combat = COMBAT_DARKDAMAGE
local defenseType = COMBAT_PHYSICALDAMAGE

local effects = {}
table.insert(effects, 445) --dir1 -- cima
table.insert(effects, 353) --dir2 -- direita
table.insert(effects, 447) --dir3 -- baixo
table.insert(effects, 446) --dir4 -- esquerda

local function spellCallback(uid, position, damage, count, dir)
	local creature = Creature(uid)
	if creature then		
		if count <= sqm then
			position:getNextPosition(dir)
			doAreaCombatHealth(uid, combat, position, area, -damage, -damage, effects[dir+1], defenseType)
			count = count + 1
			addEvent(spellCallback, time, uid, position, damage, count, dir)
		end
	end
end

function onCastSpell(creature, variant)

	local damage = damageMultiplier * creature:getTotalMeleeAttack()
	local position = creature:getPosition()
	local dir = creature:getDirection()

	spellCallback(creature.uid, position, damage, 1, dir)
	return true
end

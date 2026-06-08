local sqm = 5
local time = 400
local damageMultiplier = damageMultiplierMoves.frontlinear
local area = createCombatArea(AREA_BEAM1)

local effects = {}
table.insert(effects, 550) --dir1 -- cima
table.insert(effects, 550) --dir2 -- direita
table.insert(effects, 550) --dir3 -- baixo
table.insert(effects, 550) --dir4 -- esquerda

local function spellCallback(uid, position, damage, count, dir)
	local creature = Creature(uid)
	if creature then		
		if count <= sqm then
			position:getNextPosition(dir)
			doAreaCombatHealth(uid, COMBAT_FLYINGDAMAGE, position, area, -damage, -damage, effects[dir+1])
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

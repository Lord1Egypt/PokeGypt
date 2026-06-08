local sqm = 3
local time = 100
local damageMultiplier = damageMultiplierMoves.frontlinear
local area = createCombatArea(AREA_BEAM1)

local effects = {}
table.insert(effects, 240) --dir1 -- cima
table.insert(effects, 241) --dir2 -- direita
table.insert(effects, 242) --dir3 -- baixo
table.insert(effects, 239) --dir4 -- esquerda

local function spellCallback(uid, position, damage, count, dir)
	local creature = Creature(uid)
	if creature then		
		if count <= sqm then
			position:getNextPosition(dir)
			doAreaCombatHealth(uid, COMBAT_GROUNDDAMAGE, position, area, -damage, -damage, effects[dir+1])
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

local sqm = 5
local time = 150
local damageMultiplier = damageMultiplierMoves.frontarea
local areaDamage = createCombatArea(FRONT_AREA_2)
local combat = COMBAT_FIREDAMAGE

local effects = {}
table.insert(effects, 180) --dir1 -- cima
table.insert(effects, 181) --dir2 -- direita
table.insert(effects, 182) --dir3 -- baixo
table.insert(effects, 183) --dir4 -- esquerda

local function spellCallback(uid, position, effectPosition, damage, count, dir)
	local creature = Creature(uid)
	if creature then		
		if count <= sqm then
			effectPosition:sendMagicEffect(effects[dir+1])
			doAreaCombatHealth(uid, combat, position, areaDamage , -damage, -damage, 0)
			position:getNextPosition(dir)
			effectPosition:getNextPosition(dir)
			count = count + 1
			addEvent(spellCallback, time, uid, position, effectPosition, damage, count, dir)
		end
	end
end

function onCastSpell(creature, variant)

	local damage = damageMultiplier * creature:getTotalMagicAttack()
	local damagePosition = creature:getPosition()
	local dir = creature:getDirection()
	local effectPosition = creature:getPosition()

	damagePosition:getNextPosition(dir)
	effectPosition:getNextPosition(dir)

	spellCallback(creature.uid, damagePosition, effectPosition, damage, 1, dir)
	return true
end

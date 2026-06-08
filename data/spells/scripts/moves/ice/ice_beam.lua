local sqm = 5
local time = 400
local damageMultiplier = damageMultiplierMoves.frontlinear
local area = createCombatArea(NO_AREA)
local effects = 749

local function spellCallback(uid, position, damage, count, dir)
	local creature = Creature(uid)
	if creature then		
		if count <= sqm then
			position:getNextPosition(dir)
			doAreaCombatHealth(uid, COMBAT_ICEDAMAGE, position, area, -damage, -damage, effects)
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

local time = 500
local area = {}
table.insert(area, createCombatArea(AREA_CIRCLE3X3))
table.insert(area, createCombatArea(AREA_CIRCLE3X3))
table.insert(area, createCombatArea(AREA_CIRCLE3X3))
table.insert(area, createCombatArea(AREA_CIRCLE3X3))
table.insert(area, createCombatArea(AREA_CIRCLE3X3))
table.insert(area, createCombatArea(AREA_CIRCLE3X3))


local effect = {}
table.insert(effect, 234)
table.insert(effect, 234)
table.insert(effect, 234)
table.insert(effect, 234)
table.insert(effect, 234)
table.insert(effect, 234)

local damageMultiplier = damageMultiplierMoves.areatarget/#area

local function spellCallback(uid, position, damage, count)
	local creature = Creature(uid)
	if creature then		
		if count <= #area then
			if not effect[count] then return true end
			doAreaCombatHealth(uid, COMBAT_POISONDAMAGE, position, area[count], -damage, -damage, effect[count])
			count = count + 1			
			addEvent(spellCallback, time, uid, position, damage, count)
		end
	end
end

function onCastSpell(creature, variant)

	local damage = damageMultiplier * creature:getTotalMagicAttack()
	local position = creature:getPosition()

	spellCallback(creature.uid, position, damage, 1)
	return true
end

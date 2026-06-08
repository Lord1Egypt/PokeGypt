local time = 300
local area = {}
table.insert(area, createCombatArea(AREA_CIRCLE1X1))
table.insert(area, createCombatArea(AREA_MAGMA1))
table.insert(area, createCombatArea(AREA_MAGMA2))
table.insert(area, createCombatArea(AREA_MAGMA3))

local effect = {}
table.insert(effect, 880)
table.insert(effect, 676)
table.insert(effect, 348)
table.insert(effect, 761)

local damageMultiplier = damageMultiplierMoves.areawaves/#area

local function spellCallback(uid, position, damage, count)
	local creature = Creature(uid)
	if creature then		
		if count <= #area then
			if not effect[count] then return true end
			doAreaCombatHealth(uid, COMBAT_FIREDAMAGE, position, area[count], -damage, -damage, effect[count])
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

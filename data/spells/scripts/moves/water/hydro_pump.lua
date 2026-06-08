local combat = COMBAT_WATERDAMAGE

local area = {}
table.insert(area, createCombatArea(AREA_CIRCLE3X3))

local areaEffect = {}
table.insert(areaEffect, createCombatArea(AREA_MAGMA1))

local effect = {}
table.insert(effect, 425)

local damageMultiplier = damageMultiplierMoves.areawaves/#area

local function spellCallback(uid, position, damage, count)
	local creature = Creature(uid)
	if creature then		
		if count <= #area then
			if not effect[count] then return true end
			doAreaCombatHealth(uid, combat, position, areaEffect[count], 0, 0, effect[count])
			doAreaCombatHealth(uid, combat, position, area[count], -damage, -damage, 0)
			count = count + 1			
			addEvent(spellCallback, 500, uid, position, damage, count)
		end
	end
end

function onCastSpell(creature, variant)

	local damage = damageMultiplier * creature:getTotalMagicAttack()
	local position = creature:getPosition()
	spellCallback(creature.uid, position, damage, 1)

	return true
end

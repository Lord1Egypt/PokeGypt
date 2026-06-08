local combat = COMBAT_POISONDAMAGE

local time = 500

local areaDamage = {}
table.insert(areaDamage, createCombatArea(AREA_CIRCLE3X3))
table.insert(areaDamage, createCombatArea(AREA_CIRCLE3X3))
table.insert(areaDamage, createCombatArea(AREA_CIRCLE3X3))
table.insert(areaDamage, createCombatArea(AREA_CIRCLE3X3))
table.insert(areaDamage, createCombatArea(AREA_CIRCLE3X3))

local effect = {}
table.insert(effect, 234)
table.insert(effect, 234)
table.insert(effect, 234)
table.insert(effect, 234)
table.insert(effect, 234)

local damageMultiplier = damageMultiplierMoves.areawaves/#areaDamage

local function spellCallback(uid, position, damage, count)
	local creature = Creature(uid)
	if creature then		
		if count <= #areaDamage then
			if not effect[count] or not areaDamage[count] then return true end
			doAreaCombatHealth(uid, combat, position, areaDamage[count], -damage, -damage, effect[count])
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

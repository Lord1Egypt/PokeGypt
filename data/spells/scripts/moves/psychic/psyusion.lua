local time = 300

local area = {}
table.insert(area, createCombatArea(psy1))
table.insert(area, createCombatArea(psy2))
table.insert(area, createCombatArea(psy3))
table.insert(area, createCombatArea(psy4))
table.insert(area, createCombatArea(psy5))

local effect = {}
table.insert(effect, 256)
table.insert(effect, 253)
table.insert(effect, 256)
table.insert(effect, 253)
table.insert(effect, 257)

local damageMultiplier = damageMultiplierMoves.areatarget

local function spellCallback(uid, position, damage, count)
	local creature = Creature(uid)
	if creature then		
		if count <= #area then
			if not effect[count] then return true end
			doAreaCombatHealth(uid, COMBAT_PSYCHICDAMAGE, position, area[count], -damage, -damage, effect[count])
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

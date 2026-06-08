local time = 50
local area = {}
table.insert(area, createCombatArea(AREA_STEEL1))
table.insert(area, createCombatArea(AREA_STEEL2))
table.insert(area, createCombatArea(AREA_STEEL3))
table.insert(area, createCombatArea(AREA_STEEL4))
table.insert(area, createCombatArea(AREA_STEEL5))
table.insert(area, createCombatArea(AREA_STEEL6))
table.insert(area, createCombatArea(AREA_STEEL7))
table.insert(area, createCombatArea(AREA_STEEL8))
table.insert(area, createCombatArea(AREA_STEEL1))

local effect = {}
table.insert(effect, 524)
table.insert(effect, 524)
table.insert(effect, 524)
table.insert(effect, 524)
table.insert(effect, 524)
table.insert(effect, 524)
table.insert(effect, 524)
table.insert(effect, 524)
table.insert(effect, 524)

local damageMultiplier = damageMultiplierMoves.areawaves/#area

local function spellCallback(uid, position, positionDamage, damage, count)
	local creature = Creature(uid)
	if creature then		
		if count <= #area then
			if not effect[count] then return true end
			doAreaCombatHealth(uid, COMBAT_STEELDAMAGE, position, area[count], 0, 0, effect[count])
			doAreaCombatHealth(uid, COMBAT_STEELDAMAGE, positionDamage, area[count], -damage, -damage, 0)
			count = count + 1			
			addEvent(spellCallback, time, uid, position, positionDamage, damage, count)
		end
	end
end

function onCastSpell(creature, variant)

	local damage = damageMultiplier * creature:getTotalMagicAttack()
	local position = creature:getPosition()
	local positionDamage = creature:getPosition()
	position:getNextPosition(1)
	position:getNextPosition(2)

	spellCallback(creature.uid, position, positionDamage, damage, 1)
	return true
end

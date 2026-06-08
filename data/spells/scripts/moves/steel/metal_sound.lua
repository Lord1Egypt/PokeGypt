local time = 400
local area = {}
table.insert(area, createCombatArea(AREA_CROSS1X1))
table.insert(area, createCombatArea(AREA_SOUND1))
table.insert(area, createCombatArea(AREA_SOUND2))
table.insert(area, createCombatArea(AREA_SOUND3))
table.insert(area, createCombatArea(AREA_SOUND4))
table.insert(area, createCombatArea(AREA_SOUND3))
table.insert(area, createCombatArea(AREA_SOUND2))
table.insert(area, createCombatArea(AREA_SOUND1))
table.insert(area, createCombatArea(AREA_CROSS1X1))
table.insert(area, createCombatArea(AREA_CROSS1X1))
table.insert(area, createCombatArea(AREA_SOUND1))
table.insert(area, createCombatArea(AREA_SOUND2))
table.insert(area, createCombatArea(AREA_SOUND3))
table.insert(area, createCombatArea(AREA_SOUND4))
table.insert(area, createCombatArea(AREA_SOUND3))
table.insert(area, createCombatArea(AREA_SOUND2))
table.insert(area, createCombatArea(AREA_SOUND1))
table.insert(area, createCombatArea(AREA_CROSS1X1))

local areaDamage = {}
table.insert(areaDamage, createCombatArea(AREA_CIRCLE4X4))
table.insert(areaDamage, createCombatArea(AREA_CIRCLE4X4))
table.insert(areaDamage, createCombatArea(AREA_CIRCLE4X4))
table.insert(areaDamage, createCombatArea(AREA_CIRCLE4X4))
table.insert(areaDamage, createCombatArea(AREA_CIRCLE4X4))
table.insert(areaDamage, createCombatArea(AREA_CIRCLE4X4))
table.insert(areaDamage, createCombatArea(AREA_CIRCLE4X4))
table.insert(areaDamage, createCombatArea(AREA_CIRCLE4X4))
table.insert(areaDamage, createCombatArea(AREA_CIRCLE4X4))
table.insert(areaDamage, createCombatArea(AREA_CIRCLE4X4))
table.insert(areaDamage, createCombatArea(AREA_CIRCLE4X4))
table.insert(areaDamage, createCombatArea(AREA_CIRCLE4X4))
table.insert(areaDamage, createCombatArea(AREA_CIRCLE4X4))
table.insert(areaDamage, createCombatArea(AREA_CIRCLE4X4))
table.insert(areaDamage, createCombatArea(AREA_CIRCLE4X4))
table.insert(areaDamage, createCombatArea(AREA_CIRCLE4X4))
table.insert(areaDamage, createCombatArea(AREA_CIRCLE4X4))
table.insert(areaDamage, createCombatArea(AREA_CIRCLE4X4))

local effect = {}
table.insert(effect, 809)
table.insert(effect, 809)
table.insert(effect, 809)
table.insert(effect, 809)
table.insert(effect, 809)
table.insert(effect, 809)
table.insert(effect, 809)
table.insert(effect, 809)
table.insert(effect, 809)
table.insert(effect, 809)
table.insert(effect, 809)
table.insert(effect, 809)
table.insert(effect, 809)
table.insert(effect, 809)
table.insert(effect, 809)
table.insert(effect, 809)
table.insert(effect, 809)
table.insert(effect, 809)

local damageMultiplier = damageMultiplierMoves.ultimate/#area

local function spellCallback(uid, damage, count)
	local creature = Creature(uid)
	if creature then
		if count <= #area then
			if not effect[count] then return true end
			local position = creature:getPosition()
			doAreaCombatHealth(uid, COMBAT_STEELDAMAGE, position, areaDamage[count], -damage, -damage, 0)
			doAreaCombatHealth(uid, COMBAT_STEELDAMAGE, position, area[count], 0, 0, effect[count])
			count = count + 1			
			addEvent(spellCallback, time, uid, damage, count)
		end
	end
end

function onCastSpell(creature, variant)

	local damage = math.ceil(damageMultiplier * creature:getTotalMagicAttack())

	spellCallback(creature.uid, damage, 1)
	return true
end

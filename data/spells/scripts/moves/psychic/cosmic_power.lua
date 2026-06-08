local combat = COMBAT_PSYCHICDAMAGE
local time = 500

local area = {}
table.insert(area, createCombatArea(LeafStorm1))
table.insert(area, createCombatArea(LeafStorm2))
table.insert(area, createCombatArea(LeafStorm3))
table.insert(area, createCombatArea(LeafStorm4))
table.insert(area, createCombatArea(LeafStorm3))
table.insert(area, createCombatArea(LeafStorm2))
table.insert(area, createCombatArea(LeafStorm1))
table.insert(area, createCombatArea(LeafStorm2))
table.insert(area, createCombatArea(LeafStorm3))
table.insert(area, createCombatArea(LeafStorm4))

local areaDamage = {}
table.insert(areaDamage, createCombatArea(AREA_CIRCLE6X6))
table.insert(areaDamage, createCombatArea(AREA_CIRCLE6X6))
table.insert(areaDamage, createCombatArea(AREA_CIRCLE6X6))
table.insert(areaDamage, createCombatArea(AREA_CIRCLE6X6))
table.insert(areaDamage, createCombatArea(AREA_CIRCLE6X6))
table.insert(areaDamage, createCombatArea(AREA_CIRCLE6X6))
table.insert(areaDamage, createCombatArea(AREA_CIRCLE6X6))
table.insert(areaDamage, createCombatArea(AREA_CIRCLE6X6))
table.insert(areaDamage, createCombatArea(AREA_CIRCLE6X6))
table.insert(areaDamage, createCombatArea(AREA_CIRCLE6X6))

local effect = {}
table.insert(effect, 834)
table.insert(effect, 837)
table.insert(effect, 839)
table.insert(effect, 838)
table.insert(effect, 839)
table.insert(effect, 834)
table.insert(effect, 837)
table.insert(effect, 839)
table.insert(effect, 838)
table.insert(effect, 839)


local damageMultiplier = damageMultiplierMoves.ultimate*10/#area

local function spellCallback(uid, position, damage, count)
	local creature = Creature(uid)
	if creature then		
		if count <= #area then
			if not effect[count] then return true end
			doAreaCombatHealth(uid, combat, position, area[count], -damage, -damage, effect[count])
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
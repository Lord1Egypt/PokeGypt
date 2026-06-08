local combat = COMBAT_GROUNDDAMAGE
local defenseType = COMBAT_PHYSICALDAMAGE

local time = 300

local area = {}
table.insert(area, createCombatArea(LeafStorm1_2))
table.insert(area, createCombatArea(LeafStorm1_2))
table.insert(area, createCombatArea(LeafStorm2_2))
table.insert(area, createCombatArea(LeafStorm2_2))

local areaDamage = {}
table.insert(areaDamage, createCombatArea(AREA_CIRCLE6X6))
table.insert(areaDamage, createCombatArea(AREA_CIRCLE6X6))
table.insert(areaDamage, createCombatArea(AREA_CIRCLE6X6))
table.insert(areaDamage, createCombatArea(AREA_CIRCLE6X6))

local effect = {}
table.insert(effect, 609)
table.insert(effect, 706)
table.insert(effect, 609)
table.insert(effect, 706)

local damageMultiplier = damageMultiplierMoves.areawaves/#area

local function spellCallback(uid, position, damage, count)
	local creature = Creature(uid)
	if creature then		
		if count <= #area then
			if not effect[count] or not areaDamage[count] then return true end
			doAreaCombatHealth(uid, combat, position, area[count], 0, 0, effect[count], defenseType)
			doAreaCombatHealth(uid, combat, position, areaDamage[count], -damage, -damage, 0, defenseType)
			count = count + 1			
			addEvent(spellCallback, time, uid, position, damage, count)
		end
	end
end

function onCastSpell(creature, variant)

	local damage = damageMultiplier * creature:getTotalMeleeAttack()
	local position = creature:getPosition()

	spellCallback(creature.uid, position, damage, 1)
	return true
end

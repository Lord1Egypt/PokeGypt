local combat = COMBAT_GROUNDDAMAGE
local defenseType = COMBAT_PHYSICALDAMAGE

local time = 200

local area = {}
table.insert(area, createCombatArea(AREA_SOUND1))
table.insert(area, createCombatArea(AREA_SOUND2))
table.insert(area, createCombatArea(AREA_SOUND3))
table.insert(area, createCombatArea(AREA_SOUND4))

local areaDamage = {}
table.insert(areaDamage, createCombatArea(AREA_CIRCLE5X5))
table.insert(areaDamage, createCombatArea(AREA_CIRCLE5X5))
table.insert(areaDamage, createCombatArea(AREA_CIRCLE5X5))
table.insert(areaDamage, createCombatArea(AREA_CIRCLE5X5))

local effect = {}
table.insert(effect, 754)
table.insert(effect, 754)
table.insert(effect, 754)
table.insert(effect, 754)

local damageMultiplier = damageMultiplierMoves.ultimate/#area

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

	position:getNextPosition(1)
	position:getNextPosition(2)

	spellCallback(creature.uid, position, damage, 1)
	return true
end

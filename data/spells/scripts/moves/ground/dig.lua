local area = {}
table.insert(area, createCombatArea(AREA_CIRCLE1X1))

local effect = {}
table.insert(effect, 344)

local damageMultiplier = damageMultiplierMoves.areawaves/#area
local combat = COMBAT_GROUNDDAMAGE
local defenseType = COMBAT_PHYSICALDAMAGE

local function spellCallback(uid, position, damage, count)
	local creature = Creature(uid)
	if creature then		
		if count <= #area then
			if not effect[count] then return true end
			doAreaCombatHealth(uid, combat, position, area[count], -damage, -damage, effect[count], defenseType)
			count = count + 1			
			addEvent(spellCallback, 500, uid, position, damage, count)
		end
	end
end

function onCastSpell(creature, variant)

	local damage = damageMultiplier * creature:getTotalMeleeAttack()
	local playerPosition = creature:getPosition()

	spellCallback(creature.uid, playerPosition, damage, 1)
	return true
end

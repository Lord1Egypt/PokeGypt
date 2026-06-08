local area = {}
table.insert(area, createCombatArea(AREA_CIRCLE5X5))

local effect = {}
table.insert(effect, 256)

local damageMultiplier = damageMultiplierMoves.ultimate/#area
local combat = COMBAT_PSYCHICDAMAGE

local function spellCallback(uid, position, damage, count)
	local creature = Creature(uid)
	if creature then		
		if count <= #area then
			if not effect[count] then return true end
			doAreaCombatHealth(uid, combat, position, area[count], -damage, -damage, effect[count])
			count = count + 1			
			addEvent(spellCallback, 500, uid, position, damage, count)
		end
	end
end

function onCastSpell(creature, variant)

	local damage = damageMultiplier * creature:getTotalMagicAttack()
	local playerPosition = creature:getPosition()

	spellCallback(creature.uid, playerPosition, damage, 1)
	return true
end

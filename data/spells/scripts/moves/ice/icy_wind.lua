local time = 100
local combat = COMBAT_ICEDAMAGE

local area = {}
table.insert(area, createCombatArea(NO_AREA))
table.insert(area, createCombatArea(LINE_AREA3))
table.insert(area, createCombatArea(LINE_AREA3))
table.insert(area, createCombatArea(LINE_AREA5))
table.insert(area, createCombatArea(LINE_AREA5))

local effect = {}
table.insert(effect, 43)
table.insert(effect, 43)
table.insert(effect, 43)
table.insert(effect, 43)
table.insert(effect, 43)

local damageMultiplier = damageMultiplierMoves.areawaves

local function spellCallback(uid, position, damage, count, dir)
	local creature = Creature(uid)
	if creature then		
		if count <= #area then
			position:getNextPosition(dir)
			if not effect[count] or not area[count] then return true end
			doAreaCombatHealth(uid, combat, position, area[count], -damage, -damage, effect[count])
			count = count + 1			
			addEvent(spellCallback, time, uid, position, damage, count, dir)
		end
	end
end

function onCastSpell(creature, variant)

	local damage = damageMultiplier * creature:getTotalMagicAttack()
	local creaturePosition = creature:getPosition()
	local dir = creature:getDirection()

	spellCallback(creature.uid, creaturePosition, damage, 1, dir)
	return true
end

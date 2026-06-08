local time = 100
local combat = COMBAT_BUGDAMAGE

local area = {}
table.insert(area, createCombatArea(NO_AREA))
table.insert(area, createCombatArea(LINE_AREA3))
table.insert(area, createCombatArea(LINE_AREA3))
table.insert(area, createCombatArea(LINE_AREA5))
table.insert(area, createCombatArea(LINE_AREA5))

local effect = {}
table.insert(effect, 576)
table.insert(effect, 576)
table.insert(effect, 576)
table.insert(effect, 576)
table.insert(effect, 576)

local damageMultiplier = damageMultiplierMoves.frontarea

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
	local playerPosition = creature:getPosition()
	local dir = creature:getDirection()

	spellCallback(creature.uid, playerPosition, damage, 1, dir)
	return true
end

local time = 100

local area = {}
table.insert(area, createCombatArea(AREA_WAVE3))

local effect = {}
table.insert(effect, 576)

local damageMultiplier = damageMultiplierMoves.areawaves/#area
local combat = COMBAT_FLYINGDAMAGE
local defenseType = COMBAT_PHYSICALDAMAGE

local function spellCallback(uid, position, damage, count)
	local creature = Creature(uid)
	if creature then		
		if count <= #area then
			if not effect[count] or not area[count] then return true end
			doAreaCombatHealth(uid, combat, position, area[count], -damage, -damage, effect[count], defenseType)
			count = count + 1			
			addEvent(spellCallback, time, uid, position, damage, count)
		end
	end
end

function onCastSpell(creature, variant)

	local damage = damageMultiplier * creature:getTotalMeleeAttack()
	local creaturePosition = creature:getPosition()
	local dir = creature:getDirection()
	creaturePosition:getNextPosition(dir)

	spellCallback(creature.uid, creaturePosition, damage, 1)
	return true
end

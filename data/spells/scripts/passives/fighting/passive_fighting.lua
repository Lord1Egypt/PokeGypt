local rounds = 6
local time = 800
local damageMultiplier = damageMultiplierMoves.passive
local areaDamage = createCombatArea(AREA_SQUARE1X1)
local areaEffect = createCombatArea(NO_AREA)
local combat = COMBAT_FIGHTINGDAMAGE
local defenseType = COMBAT_PHYSICALDAMAGE
local effect = 544

local function spellCallback(uid, damage, count, posNumber)
	local creature = Creature(uid)
	if creature then		
		if count <= rounds then
			local position = creature:getPosition()
			local positionEffect = creature:getPosition()
			positionEffect:getNextPosition(1)
			positionEffect:getNextPosition(2)
			doAreaCombatHealth(uid, combat, position, areaDamage, -damage, -damage, 0, defenseType)
			doAreaCombatHealth(uid, combat, positionEffect, areaEffect, 0, 0, effect, defenseType)
			count = count + 1
			addEvent(spellCallback, time, uid, damage, count, posNumber)
		end
	end
end

function onCastSpell(creature, variant)

	local damage = damageMultiplier * creature:getTotalMeleeAttack()

	spellCallback(creature.uid, damage, 1, 1)
	return true
end

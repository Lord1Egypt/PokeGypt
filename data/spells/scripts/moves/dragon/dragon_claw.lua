local time = 100
local hits = 3
local damageMultiplier = damageMultiplierMoves.frontarea*(1+(hits-1)/4)/hits
local effect = 630
local areaDamage = createCombatArea(FRONT_AREA_2)
local areaEffect = createCombatArea(NO_AREA)
local combat = COMBAT_DRAGONDAMAGE
local defenseType = COMBAT_PHYSICALDAMAGE

local function spellCallback(uid, positionDamage, damage, count)
	local creature = Creature(uid)
	if creature then		
		if count <= hits then			
			doAreaCombatHealth(uid, combat, positionDamage, areaDamage, -damage, -damage, 0, defenseType)
			count = count + 1
			addEvent(spellCallback, time, uid, tuid, positionDamage, damage, count)
		end
	end
end

function onCastSpell(creature, variant)

	local damage = damageMultiplier * creature:getTotalMeleeAttack()
	local creaturePosition = creature:getPosition()
	local effectPosition = creature:getPosition()
	local dir = creature:getDirection()

	creaturePosition:getNextPosition(dir)
	effectPosition:getNextPosition(1)
	effectPosition:getNextPosition(2)
	effectPosition:getNextPosition(dir)
	effectPosition:getNextPosition(dir)

	doAreaCombatHealth(creature.uid, combat, effectPosition, areaEffect, 0, 0, effect, defenseType)
	spellCallback(creature.uid, creaturePosition, damage, 1)

	return true
end

local time = 300
local effect = 770
local areaEffect = createCombatArea(NO_AREA)
local areaDamage = createCombatArea(AREA_CIRCLE1X1)
local combat = COMBAT_BUGDAMAGE
local defenseType = COMBAT_PHYSICALDAMAGE

local function spellCallback(uid, damage, playerPos, effectPos, count, hits)
	local creature = Creature(uid)
	if creature then
		if count <= hits then
			doAreaCombatHealth(creature.uid, combat, effectPos, areaEffect, 0, 0, effect, defenseType)
			doAreaCombatHealth(creature.uid, combat, playerPos, areaDamage, -damage, -damage, 0, defenseType)
			count = count + 1
			damage = 2 * damage
			addEvent(spellCallback, time, uid, damage, playerPos, effectPos, count, hits)
		end
	end
end

function onCastSpell(creature, variant)

	local hits = math.random(1,3)
	local damageMultiplier = damageMultiplierMoves.frontarea*(1+(hits-1)/4)/hits
	local damage = damageMultiplier * creature:getTotalMeleeAttack()
	local playerPosition = creature:getPosition()
	local effectPosition = creature:getPosition()

	for i = 1, 2 do 
		effectPosition:getNextPosition(1)
		effectPosition:getNextPosition(2)
	end

	spellCallback(creature.uid, damage, playerPosition, effectPosition, 1, hits)
	return true
end

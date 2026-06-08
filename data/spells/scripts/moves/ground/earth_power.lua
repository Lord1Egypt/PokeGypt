local time = 300
local combat = COMBAT_GROUNDDAMAGE
local effect = 247
local area = {}
table.insert(area, createCombatArea(AREA_CIRCLE1X1))
local damageMultiplier = damageMultiplierMoves.frontarea/#area

local function spellCallback(uid, position, positionEffect, damage, count)
	local creature = Creature(uid)
	if creature then		
		if count <= #area then
			doAreaCombatHealth(uid, combat, position, area[count], -damage, -damage, 0)
			doSendMagicEffect(positionEffect, effect)
			count = count + 1			
			addEvent(spellCallback, time, uid, position, positionEffect, damage, count)
		end
	end
end

function onCastSpell(creature, variant)

	local damage = damageMultiplier * creature:getTotalMagicAttack()
	local position = creature:getPosition()
	local positionEffect = creature:getPosition()
	positionEffect:getNextPosition(1)
	positionEffect:getNextPosition(2)

	spellCallback(creature.uid, position, positionEffect, damage, 1)
	return true
end

local sqm = 5
local time = 150
local damageMultiplier = damageMultiplierMoves.frontlinear
local areaDamage = createCombatArea(FRONT_AREA_2)
local combat = COMBAT_POISONDAMAGE
local effects = 484

local function spellCallback(uid, positionDamage, positionEffect, damage, count, dir)
	local creature = Creature(uid)
	if creature then		
		if count <= sqm then
			positionEffect:sendMagicEffect(effects)
			doAreaCombatHealth(uid, combat, positionDamage, areaDamage, -damage, -damage, 0)
			positionDamage:getNextPosition(dir)
			positionEffect:getNextPosition(dir)
			count = count + 1
			addEvent(spellCallback, time, uid, positionDamage, positionEffect, damage, count, dir)
		end
	end
end

function onCastSpell(creature, variant)

	local damage = damageMultiplier * creature:getTotalMagicAttack()
	local positionDamage = creature:getPosition()
	local dir = creature:getDirection()
	local positionEffect = creature:getPosition()

	positionDamage:getNextPosition(dir)
	positionEffect:getNextPosition(dir)
	if dir == 0 then
		positionEffect:getNextPosition(dir+1)
	end
	if dir == 1 then
		positionEffect:getNextPosition(dir)
	end
	if dir == 2 then
		positionEffect:getNextPosition(dir-1)
	end

	spellCallback(creature.uid, positionDamage, positionEffect, damage, 1, dir)
	return true
end

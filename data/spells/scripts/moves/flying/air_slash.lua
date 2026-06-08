local time = 300
local hits = 3
local damageMultiplier = damageMultiplierMoves.frontarea*(1+(hits-1)/4)/hits
local areaEffect = createCombatArea(NO_AREA)
local areaDamage = createCombatArea(FRONT_AREA_2)
local combat = COMBAT_FLYINGDAMAGE

local effects = {}
table.insert(effects, 417) --dir1
table.insert(effects, 419) --dir2
table.insert(effects, 418) --dir3
table.insert(effects, 420) --dir4

local function spellCallback(uid, position, positionDamage, damage, count, dir)
	local creature = Creature(uid)
	if creature then		
		if count <= hits then			
			doAreaCombatHealth(uid, combat, position, areaEffect, 0, 0, effects[dir+1])
			doAreaCombatHealth(uid, combat, positionDamage, areaDamage, -damage, -damage, 0)
			count = count + 1
			addEvent(spellCallback, time, uid, position, positionDamage, damage, count, dir)
		end
	end
end

function onCastSpell(creature, variant)

	local damage = damageMultiplier * creature:getTotalMagicAttack()
	local positionEffect = creature:getPosition()
	local positionDamage = creature:getPosition()
	local dir = creature:getDirection()
	positionEffect:getNextPosition(dir)
	positionDamage:getNextPosition(dir)

	if dir == 0 or dir == 1 then
		positionEffect:getNextPosition(dir+1)
	else
		positionEffect:getNextPosition(dir-1)
	end

	spellCallback(creature.uid, positionEffect, positionDamage, damage, 1, dir)
	return true
end

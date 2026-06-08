local rounds = 6
local time = 100
local damageMultiplier = damageMultiplierMoves.passive
local area = createCombatArea(AREA_BEAM1)
local combat = COMBAT_ICEDAMAGE
local effect = 412 

local sequence = 
	{
		[1] = {1, -1},
		[2] = {1, 0},
		[3] = {1, 1},
		[4] = {0, 1},
		[5] = {-1, 1},
		[6] = {-1, 0},
		[7] = {-1, -1},
		[8] = {0, -1}
	}

local function spellCallback(uid, damage, count, posNumber)
	local creature = Creature(uid)
	if creature then		
		if count <= rounds then
			local position = creature:getPosition()
			position.x = position.x + sequence[posNumber][1]
			position.y = position.y + sequence[posNumber][2]
			doAreaCombatHealth(uid, combat, position, area, -damage, -damage, effect)
			posNumber = posNumber + 1
			if posNumber > #sequence then
				count = count + 1
				posNumber = 1
			end
			addEvent(spellCallback, time, uid, damage, count, posNumber)
		end
	end
end

function onCastSpell(creature, variant)

	local damage = damageMultiplier * creature:getTotalMagicAttack()

	spellCallback(creature.uid, damage, 1, 1)
	return true
end

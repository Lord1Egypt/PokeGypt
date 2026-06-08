local rounds = 6
local time = 100
local damageMultiplier = damageMultiplierMoves.areawaves*(1+(rounds-1)/4)/rounds
local area = createCombatArea(NO_AREA)
local combat = COMBAT_DRAGONDAMAGE
local effect = 576

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

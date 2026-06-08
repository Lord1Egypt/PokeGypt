local sqm = 5
local damageMultiplier = 20
local combatArea = {}
local area = 
{

{ {2, 1} }, { {2, 0, 1 } }, { {2, 0, 0, 1} }, { {2, 0, 0, 0, 1} }, { {2, 0, 0, 0, 0, 1} },

{ {1, 2} }, { {1, 0, 2 } }, { {1, 0, 0, 2} }, { {1, 0, 0, 0, 2} }, { {1, 0, 0, 0, 0, 2} },

{
{2},
{1}
},
{
{2},
{0},
{1}
},
{
{2},
{0},
{0},
{1}
},
{
{2},
{0},
{0},
{0},
{1}
},
{
{2},
{0},
{0},
{0},
{0},
{1}
},

{
{1},
{2}
},
{
{1},
{0},
{2}
},
{
{1},
{0},
{0},
{2}
},
{
{1},
{0},
{0},
{0},
{2}
},
{
{1},
{0},
{0},
{0},
{0},
{2}
}

} 

for i = 1, 4 * sqm do
        table.insert(combatArea, createCombatArea(area[i]))
end

function spellCallback(cid, position, damage, countStart, count)
	if Creature(cid) then		
		if count < countStart + sqm then
			doAreaCombatHealth(cid, COMBAT_FIREDAMAGE, position, combatArea[count], -damage, -damage, CONST_ME_FIREAREA)
			count = count + 1
			addEvent(spellCallback, 100, cid, position, damage, countStart, count)
		end
	end
end

function onCastSpell(creature, variant)
	local master = creature:getMaster()
	if not master then return true end

	local masterPos = master:getPosition()
	local summonPos = creature:getPosition()

	local monsterType = MonsterType(creature:getName())
	local damage = damageMultiplier * creature:getTotalMagicAttack() 

	local direction = creature:getDirection()
	local countStart = 1

	if masterPos.x < summonPos.x then
		if direction == DIRECTION_SOUTH then
			countStart = countStart + 0 * sqm
		elseif direction == DIRECTION_NORTH then
			countStart = countStart + 1 * sqm
		elseif direction == DIRECTION_WEST then
			countStart = countStart + 2 * sqm
		elseif direction == DIRECTION_EAST then
			countStart = countStart + 3 * sqm
		end
	elseif masterPos.x > summonPos.x then
		if direction == DIRECTION_NORTH then
			countStart = countStart + 0 * sqm
		elseif direction == DIRECTION_SOUTH then
			countStart = countStart + 1 * sqm
		elseif direction == DIRECTION_EAST then
			countStart = countStart + 2 * sqm
		elseif direction == DIRECTION_WEST then
			countStart = countStart + 3 * sqm
		end
	else
		if direction == DIRECTION_WEST then
			countStart = countStart + 0 * sqm
		elseif direction == DIRECTION_EAST then
			countStart = countStart + 1 * sqm
		elseif direction == DIRECTION_NORTH then
			countStart = countStart + 2 * sqm
		elseif direction == DIRECTION_SOUTH then
			countStart = countStart + 3 * sqm
		end
	end

	spellCallback(master:getId(), summonPos, damage, countStart, countStart)
	return true
end

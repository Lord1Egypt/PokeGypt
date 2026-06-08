local area = createCombatArea(AREA_BEAM1)
local combat = COMBAT_PSYCHICDAMAGE

local effects = {}

effects[0] = {228, 228, 228, 228, 228, 228} -- norte
effects[1] = {226, 226, 226, 226, 226, 226} -- leste
effects[2] = {229, 229, 229, 229, 229, 229} -- sul
effects[3] = {227, 227, 227, 227, 227, 227} -- oeste

local damageMultiplier = damageMultiplierMoves.frontlinear

local function spellCallback(uid, position, damage, count, dir)
	local creature = Creature(uid)
	if creature then		
		if count <= #effects[0] then
			position:getNextPosition(dir)
			doAreaCombatHealth(uid, combat, position, area, -damage, -damage, effects[dir][count])
			count = count + 1
			spellCallback(uid, position, damage, count, dir)
		end
	end
end

function onCastSpell(creature, variant)

	local damage = damageMultiplier * creature:getTotalMagicAttack()
	local position = creature:getPosition()
	local dir = creature:getDirection()

	spellCallback(creature.uid, position, damage, 1, dir)
	return true
end

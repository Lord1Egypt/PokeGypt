local time = 300
local effect = 238
local hits = 5
local damageMultiplier = damageMultiplierMoves.frontlinear*(1+(hits-1)/4)/hits
local areaDamage = createCombatArea(AREA_CIRCLE1X1)
local combat = COMBAT_ROCKDAMAGE
local defenseType = COMBAT_PHYSICALDAMAGE

local function spellCallback(uid, damage, creaturePosition, count)
	local creature = Creature(uid)
	if creature then
		if count <= hits then
			doAreaCombatHealth(creature.uid, combat, creaturePosition, areaDamage, -damage, -damage, effect, defenseType)
			count = count + 1
			addEvent(spellCallback, time, uid, damage, creaturePosition, count)
		end
	end
end

function onCastSpell(creature, variant)

	local damage = damageMultiplier * creature:getTotalMeleeAttack()
	local creaturePosition = creature:getPosition()

	spellCallback(creature.uid, damage, creaturePosition, 1)
	return true
end

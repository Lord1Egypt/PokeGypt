local missileEffect = 0
local areaEffect = 752
local waves = 3
local time = 100
local area = createCombatArea(AREA_BEAM1)
local combat = COMBAT_FIGHTINGDAMAGE
local defenseType = COMBAT_PHYSICALDAMAGE
local damageMultiplier = damageMultiplierMoves.frontarea/waves

local function spellCallback(uid, tuid, damage, count)
	local creature = Creature(uid)
	local target = Creature(tuid)
	if creature and target then
		if count <= waves then
			local creaturePosition = creature:getPosition()
			local targetPosition = target:getPosition()

			doSendDistanceShoot(creaturePosition, targetPosition, missileEffect)
			doAreaCombatHealth(creature.uid, combat, targetPosition, area, -damage, -damage, areaEffect, defenseType)
			count = count + 1
			addEvent(spellCallback, time, uid, tuid, damage, count)
		end
	end
end

function onCastSpell(creature, variant)
	local target = creature:getTarget()
	if not target then return true end

	local damage = damageMultiplier * creature:getTotalMeleeAttack()

	spellCallback(creature.uid, target.uid, damage, 1)
	return true
end

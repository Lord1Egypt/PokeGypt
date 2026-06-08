local time = 500
local areaEffect = 233
local hits = 2
local damageMultiplier = damageMultiplierMoves.singletarget*(1+(hits-1)/4)/hits
local combat = COMBAT_FIGHTINGDAMAGE
local defenseType = COMBAT_PHYSICALDAMAGE

local function spellCallback(uid, tuid, damage, count)
	local creature = Creature(uid)
	local target = Creature(tuid)
	if creature and target then
		if count <= hits then
			local targetPosition = target:getPosition()
			doTargetCombatHealth(creature.uid, target, combat, -damage, -damage, areaEffect, defenseType)
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

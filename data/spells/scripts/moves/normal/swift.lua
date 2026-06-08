local time = 300
local missileEffect = 115
local effect = 880
local hits = 3
local damageMultiplier = damageMultiplierMoves.singletarget*(1+(hits-1)/4)/hits
local combat = COMBAT_NORMALDAMAGE

local function spellCallback(uid, tuid, damage, count)
	local creature = Creature(uid)
	local target = Creature(tuid)
	if creature and target then
		if count <= hits then
			local targetPosition = target:getPosition()
			doTargetCombatHealth(creature.uid, target, combat, -damage, -damage, effect)
			count = count + 1
			addEvent(spellCallback, time, uid, tuid, damage, count)
		end
	end
end

function onCastSpell(creature, variant)
	local target = creature:getTarget()
	if not target then return true end
      
	local creaturePosition = creature:getPosition()
	local targetPosition = target:getPosition()
	
	local damage = damageMultiplier * creature:getTotalMagicAttack()
	doSendDistanceShoot(creaturePosition, targetPosition, missileEffect)
	spellCallback(creature.uid, target.uid, damage, 1)

	return true
end

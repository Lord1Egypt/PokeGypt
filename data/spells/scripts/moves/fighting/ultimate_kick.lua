local damageMultiplier = damageMultiplierMoves.ultimate
local time = 400
local damageEffect = 233
local teleportEffect = 331
local combat = COMBAT_FIGHTINGDAMAGE
local defenseType = COMBAT_PHYSICALDAMAGE

local function spellCallback(uid, targets, damage, targetNumber)
	local creature = Creature(uid)
	local target = Creature(targets[targetNumber])
	if creature and target then
		if targetNumber <= #targets then
			local targetPosition = target:getPosition()
			creature:getPosition():sendMagicEffect(teleportEffect)

			local random = math.random(0,3)			
			targetPosition:getNextPosition(random)
			local newPos = creature:getClosestFreePosition(targetPosition, 0, true)
			newPos:sendMagicEffect(teleportEffect)
			creature:teleportTo(newPos)

			doTargetCombatHealth(creature.uid, target, combat, -damage, -damage, damageEffect, defenseType)

			targetNumber = targetNumber + 1
			addEvent(spellCallback, time, uid, targets, damage, targetNumber)
		end
	end
end


function onCastSpell(creature, variant)

	local spectators = Game.getSpectators(creature:getPosition(), false, false, 0, 6, 0, 6)
	local targets = {}
	for i = 1, #spectators do
		local spectator = spectators[i]
		if not spectator:isPlayer() and not spectator:isNpc() then
			if spectator ~= creature then
				targets[#targets + 1] = spectator.uid
			end
		end
	end


	local damage = damageMultiplier * creature:getTotalMeleeAttack()

	spellCallback(creature.uid, targets, damage, 1)

	return true
end

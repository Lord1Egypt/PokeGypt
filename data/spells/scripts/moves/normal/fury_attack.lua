local time = 300
local areaEffect = 819
local teleportEffect = 331
local hits = math.random(2,5)
local damageMultiplier = damageMultiplierMoves.singletargetweak*(1+(hits-1)/4)/hits
local combat = COMBAT_NORMALDAMAGE
local defenseType = COMBAT_PHYSICALDAMAGE

local function spellCallback(uid, tuid, damage, count)
	local creature = Creature(uid)
	local target = Creature(tuid)
	if creature and target then
		if count <= hits then
			local targetPosition = target:getPosition()
			local effectPosition = target:getPosition()
			effectPosition:getNextPosition(1)
			effectPosition:getNextPosition(2)
			effectPosition:sendMagicEffect(areaEffect)
			creature:getPosition():sendMagicEffect(teleportEffect)

			local random = math.random(0,3)			
			targetPosition:getNextPosition(random)
			local newPos = creature:getClosestFreePosition(targetPosition, 0, true)
			newPos:sendMagicEffect(teleportEffect)
			creature:teleportTo(newPos)

			doTargetCombatHealth(creature.uid, target, combat, -damage, -damage, 0, defenseType)

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

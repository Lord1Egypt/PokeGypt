local time = 600
local areaEffect = 334
local hits = math.random(1,5)
local area = createCombatArea(NO_AREA)
local combat = COMBAT_GHOSTDAMAGE

local function spellCallback(uid, tuid, damage, count)
	local creature = Creature(uid)
	local target = Creature(tuid)
	if creature and target then
		if count <= hits then
			local targetPosition = target:getPosition()
			doAreaCombatHealth(creature.uid, combat, targetPosition, area, -damage, -damage, areaEffect)
			count = count + 1
			damage = 1.5 * damage
			addEvent(spellCallback, time, uid, tuid, damage, count)
		end
	end
end

function onCastSpell(creature, variant)
	local target = creature:getTarget()
	if not target then return true end

	local damage = creature:getTotalMagicAttack()

	spellCallback(creature.uid, target.uid, damage, 1)
	return true
end


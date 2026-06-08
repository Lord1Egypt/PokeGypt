local time = 300
local areaEffect = 268
local hits = 2
local damageMultiplier = damageMultiplierMoves.singletargetweak*(1+(hits-1)/4)/hits
local combat = COMBAT_NORMALDAMAGE
local defenseType = COMBAT_PHYSICALDAMAGE

local function spellCallback(uid, tuid, damage, count)
	local creature = Creature(uid)
	local target = Creature(tuid)
	if creature and target then
		if count <= hits then
			doTargetCombatHealth(creature.uid, target, combat, -damage, -damage, 0, defenseType)
			if count == 1 then
				target:getPosition():sendMagicEffect(areaEffect)
			end
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

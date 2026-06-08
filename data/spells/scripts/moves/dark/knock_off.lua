local areaEffect = 493
local hits = 3
local time = 400
local combat = COMBAT_DARKDAMAGE
local damageMultiplier = damageMultiplierMoves.singletarget*(1+(hits-1)/4)/hits

local function spellCallback(uid, tuid, damage, count)
	local creature = Creature(uid)
	local target = Creature(tuid)
	if creature and target then
		if count <= hits then
			doTargetCombatHealth(uid, target, combat, -damage, -damage, areaEffect)
			count = count + 1
			addEvent(spellCallback, time, uid, tuid, damage, count)
		end
	end
end

function onCastSpell(creature, variant)
	local target = creature:getTarget()
	if not target then return true end

	local damage = damageMultiplier * creature:getTotalMagicAttack()

	spellCallback(creature.uid, target.uid, damage, 1)
	return true
end

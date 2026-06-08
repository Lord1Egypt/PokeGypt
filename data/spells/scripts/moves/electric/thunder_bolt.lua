local time = 100
local waves = 4
local delay = 30
local damageMultiplier = damageMultiplierMoves.areawaves/waves
local projectileEffectUp = 93
local projectileEffectDown = 93
local targetEffect = 877

local function sendDown(uid, tuid, toposup, toposdown)
	local creature = Creature(uid)
	local target = Creature(tuid)
	if creature and target then
		doSendDistanceShoot(toposup, toposdown, projectileEffectDown)
	end
end

local function dealDamage(uid, tuid, position, damage, toposdown)
	local creature = Creature(uid)
	local target = Creature(tuid)
	if creature and target then
		doTargetCombatHealth(uid, target, COMBAT_ELECTRICDAMAGE, -damage,-damage, targetEffect)
	end
end

local function spellCallback(uid, tuid, damage, count)
	local creature = Creature(uid)
	local target = Creature(tuid)
	if creature and target then
		local position = creature:getPosition()
		local toposup = creature:getPosition()
		local toposdown = target:getPosition()
		toposup.x = toposup.x + math.random(-4,4)
		toposup.y = toposup.y + math.random(-15,-5)
		if count <= waves then
			local d = getDistanceBetween(toposup, toposdown)
			local dt = delay + d * 37			
			local tile = Tile(toposdown)
			if tile and not (tile:getHouse() or tile:hasFlag(TILESTATE_PROTECTIONZONE) or tile:hasFlag(TILESTATE_FLOORCHANGE) or tile:hasFlag(TILESTATE_BLOCKSOLID)) then
				doSendDistanceShoot(position, toposup, projectileEffectUp)
				addEvent(sendDown, delay, uid, tuid, toposup, toposdown)
				addEvent(dealDamage, dt, uid, tuid, position, damage, toposdown)
			end
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

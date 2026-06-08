local time = 10
local waves = 10
local delay = 1000
local side = "right" --lado q vai a magia
local damageMultiplier = damageMultiplierMoves.ultimate/waves
local projectileEffectUp = 100
local projectileEffectDown = 100
local areaEffect = 379
local areaSize = 5 --area queda missile
local area = createCombatArea(AREA_CIRCLE5X5) --area dano
local combat = COMBAT_FIREDAMAGE

local function sendDown(uid, toposup, toposdown)
	local creature = Creature(uid)
	if creature then
		doSendDistanceShoot(toposup, toposdown, projectileEffectDown)
	end
end

local function dealDamage(uid, position, damage, toposdown)
	local creature = Creature(uid)
	if creature then
		doSendMagicEffect(toposdown, areaEffect)
		doAreaCombatHealth(uid, combat, position, area, -damage, -damage, 0)
	end
end

local function spellCallback(uid, damage, count)
	local creature = Creature(uid)
	if creature then
		local position = creature:getPosition()
		local toposup = creature:getPosition()
		local toposdown = creature:getPosition()
		
		if side == "left" then
			toposup.x = toposup.x + math.random(-10,-10)
		else
			toposup.x = toposup.x + math.random(10,10)
		end
		toposup.y = toposup.y + math.random(-8,-6)
		toposdown.x = toposdown.x + math.random(-areaSize,areaSize)
		toposdown.y = toposdown.y + math.random(-areaSize,areaSize)
		if count <= waves then
			local d = getDistanceBetween(toposup, toposdown)
			local dt = delay + d * 37
			
			local tile = Tile(toposdown)
			if tile and not (tile:getHouse() or tile:hasFlag(TILESTATE_PROTECTIONZONE) or tile:hasFlag(TILESTATE_FLOORCHANGE) or tile:hasFlag(TILESTATE_BLOCKSOLID)) then
				doSendDistanceShoot(position, toposup, projectileEffectUp)
				addEvent(sendDown, delay, uid, toposup, toposdown)
			end
			addEvent(dealDamage, dt, uid, position, damage, toposdown)
			count = count + 1			
			addEvent(spellCallback, time, uid, damage, count)
		end
	end
end

function onCastSpell(creature, variant)

	local damage = math.ceil(damageMultiplier * creature:getTotalMagicAttack())

	spellCallback(creature.uid, damage, 1)
	return true
end

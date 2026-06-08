local time = 300
local hits = 1
local damageMultiplier = damageMultiplierMoves.areawaves*(1+(hits-1)/4)/hits
local areaDamage = createCombatArea(AREA_WAVE4)
local combat = COMBAT_ELECTRICDAMAGE

local effects = {}
table.insert(effects, 492) --dir1 -- cima
table.insert(effects, 656) --dir2 -- direita
table.insert(effects, 654) --dir3 -- baixo 
table.insert(effects, 655) --dir4 -- esquerda

local function spellCallback(uid, position, creaturePosition, damage, count, dir)
	local creature = Creature(uid)
	if creature then		
		if count <= hits then			
			position:sendMagicEffect(effects[dir+1])
			doAreaCombatHealth(uid, combat, creaturePosition, areaDamage, -damage, -damage, 0)
			count = count + 1
			addEvent(spellCallback, time, uid, position, creaturePosition, damage, count, dir)
		end
	end
end

function onCastSpell(creature, variant)

	local damage = damageMultiplier * creature:getTotalMagicAttack()
	local position = creature:getPosition()
	local creaturePosition = creature:getPosition()
	local dir = creature:getDirection()
	position:getNextPosition(dir)
	creaturePosition:getNextPosition(dir)

	if dir == 0 then
		position:getNextPosition(dir+1)
	elseif dir == 2 then
		position:getNextPosition(dir-1)
	end
	if dir == 1 or dir == 2 then
		for i=1, 5 do
			position:getNextPosition(dir)
		end
	end

	spellCallback(creature.uid, position, creaturePosition, damage, 1, dir)
	return true
end

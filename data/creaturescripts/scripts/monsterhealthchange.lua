local criticalProbability = 1
local blockedProbability = 1
local racesStrength = 
	{
		["none"] = {strong = {}, weak = {}},
		["blood"] = {strong = {}, weak = {}},
		["physical"] = {strong = {}, weak = {}},
		["healing"] = {strong = {}, weak = {}},
		["fire"] = {strong = {"grass", "ice", "bug", "steel"}, weak = {"water", "ground", "rock"}},
		["grass"] = {strong = {"water", "ground", "rock"}, weak = {"fire", "ice", "poison", "flying", "bug"}},
		["normal"] = {strong = {}, weak = {"fighting"}},
		["water"] = {strong = {"fire", "ground", "rock"}, weak = {"electric", "grass"}},
		["flying"] = {strong = {"grass", "fighting", "bug"}, weak = {"electric", "ice", "rock"}},
		["poison"] = {strong = {"grass", "fairy"}, weak = {"ground", "psychic"}},
		["earth"] = {strong = {"grass", "fairy"}, weak = {"ground", "psychic"}}, --correct CONDITION_POISON = COMBAT_EARTHDAMAGE
		["electric"] = {strong = {"water", "flying"}, weak = {"ground"}},
		["ground"] = {strong = {"fire", "electric", "poison", "rock", "steel"}, weak = {"water", "grass", "ice"}},
		["psychic"] = {strong = {"fighting", "poison"}, weak = {"bug", "ghost", "dark"}},
		["rock"] = {strong = {"fire", "ice", "flying", "bug"}, weak = {"water", "grass", "fighting", "ground", "steel"}},
		["ice"] = {strong = {"grass", "ground", "flying", "dragon"}, weak = {"fire", "fighting", "rock", "steel"}},
		["bug"] = {strong = {"grass", "psychic", "dark"}, weak = {"fire", "flying", "rock"}},
		["dragon"] = {strong = {"dragon"}, weak = {"ice", "dragon", "fairy"}},
		["ghost"] = {strong = {"psychic", "ghost"}, weak = {"ghost", "dark"}},
		["dark"] = {strong = {"psychic", "ghost"}, weak = {"fighting", "bug", "fairy"}},
		["steel"] = {strong = {"ice", "rock", "fairy"}, weak = {"fire", "fighting", "ground"}},
		["fairy"] = {strong = {"fighting", "dragon", "dark"}, weak = {"poison", "steel"}},
		["fighting"] = {strong = {"normal", "ice", "rock", "dark", "steel"}, weak = {"flying", "psychic", "fairy"}}
	}

local function isStrongAgainst(attackerRace, defenderRace, defenderRace2)

	if isInArray(racesStrength[attackerRace].strong, defenderRace) or isInArray(racesStrength[attackerRace].strong, defenderRace2) then
		return true
	end

	return false
end

local function isWeakAgainst(attackerRace, defenderRace, defenderRace2)

	if isInArray(racesStrength[attackerRace].weak, defenderRace) or isInArray(racesStrength[attackerRace].weak, defenderRace2) then
		return true
	end

	return false
end

function onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType)

	if not attacker then
		return primaryDamage, primaryType, secondaryDamage, secondaryType
	end
	if creature:isPlayer() or attacker:isPlayer() then
		if primaryDamage then primaryDamage = math.floor(primaryDamage * 0.08) end
		return primaryDamage, primaryType, secondaryDamage, secondaryType
	end

	local primaryTypeName = getCombatName(primaryType)
	local secondaryTypeName = getCombatName(secondaryType)

	local localDamageMultiplier = 1.0

	local masterLevel
	local summonLevel
	local summonBoost
	local summonLove

	if attacker:getMaster() and attacker:getMaster():isNpc() then
		masterLevel = 100
		summonLevel = attacker:getLevel()
		summonBoost = 0
		summonLove = 0
	else
		masterLevel = attacker:getMasterLevel()
		summonLevel = attacker:getLevel()
		summonBoost = attacker:getBoost()
		summonLove = attacker:getLove()
	end

	local formulaDamage = damageFormula(masterLevel, summonLevel, summonBoost, summonLove)
	localDamageMultiplier = localDamageMultiplier * formulaDamage

	if secondaryTypeName == "physical" then
		local defenseDamping = (1-creature:getTotalDefense()/600)
		if defenseDamping <= 0.5 then 
			defenseDamping = 0.5
		elseif defenseDamping >= 1 then
			defenseDamping = 1
		end
		localDamageMultiplier = localDamageMultiplier * defenseDamping
	else
		if primaryTypeName ~= "physical" and creature:getTotalMagicDefense() > 0 then	
			local defenseDamping = (1-creature:getTotalMagicDefense()/600)
			if defenseDamping <= 0.5 then 
				defenseDamping = 0.5
			elseif defenseDamping >= 1 then
				defenseDamping = 1
			end
			localDamageMultiplier = localDamageMultiplier * defenseDamping
		end
	end

	local defenderMonsterType = MonsterType(creature:getName())
	local defenderRace = defenderMonsterType:getRaceName()
	local defenderRace2 = defenderMonsterType:getRace2Name()

	if isStrongAgainst(primaryTypeName, defenderRace, defenderRace2) then
		localDamageMultiplier = localDamageMultiplier * 1.5
	end

	if isWeakAgainst(primaryTypeName, defenderRace, defenderRace2) then
		localDamageMultiplier = localDamageMultiplier / 1.5
	end

	if math.random(1, 100) <= criticalProbability then
		localDamageMultiplier = localDamageMultiplier * 1.5
		Game.sendAnimatedText(creature:getPosition(), "CRITICAL", TEXTCOLOR_RED)
	else
		if math.random(1, 100) <= blockedProbability then
			localDamageMultiplier = 0.0
			Game.sendAnimatedText(creature:getPosition(), "BLOCKED", TEXTCOLOR_LIGHTGREY)
		end
	end

	if attacker:isPokemon() and creature:isPokemon() then --duel between players
		localDamageMultiplier = localDamageMultiplier / 7.0
	end

	if not attacker:isPokemon() and creature:isPokemon() then --wild pokemon damage
		localDamageMultiplier = localDamageMultiplier / 3.0
	end

	localDamageMultiplier = localDamageMultiplier * (0.3 + math.random(1, 20) * 0.01)

	if primaryDamage then primaryDamage = math.floor(primaryDamage * localDamageMultiplier) end
	if secundaryDamage then secondaryDamage = math.floor(secondaryDamage * localDamageMultiplier) end

	return primaryDamage, primaryType, secondaryDamage, secondaryType
end

-- PokeGypt GOD tool: give a pokeball (with a captured pokemon) to a player
-- Usage: /givepokeball playerName, pokemonName, level, boost, love
-- (level/boost/love optional; default level 1, boost 0, love 0)
function onSay(player, words, param)
	if player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end

	local split = param:split(",")

	local target = Player(split[1] and split[1]:gsub("^%s+", ""):gsub("%s+$", "") or "")
	if target == nil then
		player:sendCancelMessage("A player with that name is not online.")
		return false
	end

	local name = split[2] and split[2]:gsub("^%s+", ""):gsub("%s+$", "") or ""
	local monsterType = MonsterType(name)
	if not monsterType then
		player:sendCancelMessage("Pokemon not found.")
		return false
	end
	name = firstToUpper(name)

	local level = tonumber(split[3]) or 1
	local boost = tonumber(split[4]) or 0
	local love = tonumber(split[5]) or 0

	local result = target:addItem(26670, 1, false, 1, CONST_SLOT_BACKPACK)
	if result == nil then
		player:sendCancelMessage(target:getName() .. "'s backpack is full.")
		return false
	end

	local baseHealth = monsterType:getMaxHealth()
	local maxHealth = math.floor(baseHealth * statusGainFormula(target:getLevel(), level, boost, love))
	result:setSpecialAttribute("pokeName", name)
	result:setSpecialAttribute("pokeLevel", level)
	result:setSpecialAttribute("pokeBoost", boost)
	result:setSpecialAttribute("pokeLove", love)
	result:setSpecialAttribute("pokeExperience", getNeededExp(level))
	result:setSpecialAttribute("pokeMaxHealth", maxHealth)
	result:setSpecialAttribute("pokeHealth", maxHealth)

	target:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You received a " .. name .. " (Lv " .. level .. ") from " .. player:getName() .. ".")
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You gave a " .. name .. " (Lv " .. level .. ") to " .. target:getName() .. ".")
	return false
end

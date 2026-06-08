function onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end

	if player:getAccountType() < ACCOUNT_TYPE_GOD then
		return false
	end

	local split = param:split(",")
	local name = split[1]
	local monsterType = MonsterType(name)
	if not monsterType then
		player:sendCancelMessage("Pokemon not found.")
		return false		
	end

	name = firstToUpper(name)

	local level = tonumber(split[2])
	if level == nil then
		level = 1
	end

	local boost = tonumber(split[3])
	if boost == nil then
		boost = 0
	end

	local love = tonumber(split[4])
	if love == nil then
		love = 0
	end

	local result = player:addItem(26670, 1, false, 1, CONST_SLOT_BACKPACK)
	if result ~= nil then
		local baseHealth = monsterType:getMaxHealth()
		local maxHealth = math.floor(baseHealth * statusGainFormula(player:getLevel(), level, boost, love))
		result:setSpecialAttribute("pokeName", name)
		result:setSpecialAttribute("pokeLevel", level)
		result:setSpecialAttribute("pokeBoost", boost)
		result:setSpecialAttribute("pokeLove", love)
		result:setSpecialAttribute("pokeExperience", getNeededExp(level))
		result:setSpecialAttribute("pokeMaxHealth", maxHealth)
		result:setSpecialAttribute("pokeHealth", maxHealth)
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
		return true
	else
		player:sendCancelMessage("Backpack full.")
	end
	return false
end

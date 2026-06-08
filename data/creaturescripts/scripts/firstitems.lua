local firstItems = {8922, 1988}
local name = "Pikachu"
--local portraitId = 27141

function onLogin(player)
	if player:getLastLoginSaved() == 0 then
		for i = 1, #firstItems do
			player:addItem(firstItems[i], 1)
		end
		-- Check slots	
		player:addSlotItems()
--		player:addItem(player:getSex() == 0 and 2651 or 2650, 1)
--		player:addItem(1987, 1):addItem(2674, 1)
		local monsterType = MonsterType(name)
		local baseHealth = monsterType:getMaxHealth()
		local maxHealth = math.floor(baseHealth * statusGainFormula(player:getLevel(), 1, 0, 0))
		local backpack = player:getSlotItem(CONST_SLOT_BACKPACK)
		local addPokeball = backpack:addItem(26661, 1)
--		player:addItem(27141, 1, false, 1, CONST_SLOT_HEAD)
		if addPokeball then
			addPokeball:setSpecialAttribute("pokeName", name)
			addPokeball:setSpecialAttribute("pokeLevel", 1)
			addPokeball:setSpecialAttribute("pokeExperience", 0)
			addPokeball:setSpecialAttribute("pokeBoost", 0)
			addPokeball:setSpecialAttribute("pokeMaxHealth", maxHealth)
			addPokeball:setSpecialAttribute("pokeHealth", maxHealth)
			addPokeball:setSpecialAttribute("pokeLove", 0)
		else
			print("WARNING! Player " .. player:getName() .. " without initial pokeball.")
		end
		player:addItem(26662, 100)
		player:addItem(27646, 20)
		player:addItem(27645, 20)
	end
	return true
end

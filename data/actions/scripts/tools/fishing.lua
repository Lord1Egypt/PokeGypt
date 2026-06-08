local useWorms = false
local maxSkill = 100

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local targetId = target.itemid
	if not isInArray(waterIds, target.itemid) then
		return false
	end

	local summons = player:getSummons()
	if #summons <= 0 then
		player:sendCancelMessage("Sorry, not possible. You need a Pokemon to be able to fish.")
		return true 
	end

	local summonTile = summons[1]:getTile()
	if summonTile:getHouse() or summonTile:hasFlag(TILESTATE_PROTECTIONZONE) then
		player:sendCancelMessage("Sorry, not possible. Your summon must be outside a protection zone.")
		return true 
	end

	if targetId == 493 or targetId == 15402 then
		return true
	end

	if targetId == 10499 then
		local owner = target:getAttribute(ITEM_ATTRIBUTE_CORPSEOWNER)
		if owner ~= 0 and owner ~= player:getId() then
			player:sendTextMessage(MESSAGE_STATUS_SMALL, "You are not the owner.")
			return true
		end

		toPosition:sendMagicEffect(CONST_ME_WATERSPLASH)
		target:remove()
	end

	if targetId ~= 7236 then
		toPosition:sendMagicEffect(CONST_ME_LOSEENERGY)
	end

	if player:getEffectiveSkillLevel(SKILL_FISHING) <= maxSkill then
		player:addSkillTries(SKILL_FISHING, 1)
	end

	local monsterTrash = {"Magikarp"}
	local monsterVeryCommon = {"Magikarp", "Horsea", "Goldeen", "Krabby", "Poliwag", "Staryu"}
	local monsterCommon = {"Magikarp", "Horsea", "Goldeen", "Tentacool", "Krabby", "Poliwag", "Staryu", "Psyduck"}
	local monsterMildRare = {"Magikarp", "Horsea", "Goldeen", "Tentacool", "Krabby", "Poliwag", "Staryu", "Psyduck","Seadra", "Seaking", "Kingler"}
	local monsterRare = {"Magikarp", "Horsea", "Goldeen", "Tentacool", "Krabby", "Poliwag", "Staryu","Psyduck", "Seadra", "Seaking", "Kingler", "Poliwhirl", "Starmie"}
	local monsterVeryRare = {"Magikarp", "Horsea", "Goldeen", "Tentacool", "Krabby", "Poliwag", "Staryu", "Psyduck", "Seadra", "Seaking","Kingler","Poliwhirl","Starmie","Golduck","Tentacruel"}
	local monsterUltraRare = {"Magikarp", "Horsea", "Goldeen", "Tentacool", "Krabby", "Poliwag", "Staryu", "Psyduck", "Seadra", "Seaking", "Kingler", "Poliwhirl", "Starmie", "Golduck", "Tentacruel", "Kingdra", "Gyarados"}

	local position = player:getPosition()

	if player:getPremiumDays() > 0 then
--		local town = Town(position:getClosestTownId())
		local town = Town("Saffron")
		if not town then
			town = Town("Saffron")
		end
		local townName = town:getName()
		--third gen region pokemons: eirian, eternia, arcania, lunna, nostrus, natturu, outland
		if townName == "Eirian" or townName == "Eternia" or townName == "Arcania" or townName == "Lunna" or townName == "Nostrus" or townName == "Natturu" then
        		monsterTrash = {"Magikarp", "Barboach"}
        		monsterVeryCommon = {"Magikarp", "Barboach", "Corphish"}
        		monsterCommon = {"Magikarp", "Barboach", "Corphish", "Carvanha", "Whiscash"}
        		monsterMildRare = {"Magikarp", "Barboach", "Corphish", "Carvanha", "Whiscash", "Crawdaunt", "Clamperl", "Luvdisc"}
        		monsterRare = {"Magikarp", "Barboach", "Corphish", "Carvanha", "Whiscash", "Crawdaunt", "Clamperl", "Luvdisc", "Sharpedo", "Wailmer"}
        		monsterVeryRare = {"Magikarp", "Barboach", "Corphish", "Carvanha", "Whiscash", "Crawdaunt", "Clamperl", "Luvdisc", "Sharpedo", "Wailmer", "Huntail", "Gorebyss"} 
        		monsterUltraRare = {"Magikarp", "Barboach", "Corphish", "Carvanha", "Whiscash", "Crawdaunt", "Clamperl", "Luvdisc", "Sharpedo", "Wailmer", "Huntail", "Gorebyss", "Gyarados", "Wailord"}
		--additional ultra rare pokemon in outland    
        	elseif townName == "Outland" then
            		monsterUltraRare = {"Magikarp", "Barboach", "Corphish", "Carvanha", "Whiscash", "Crawdaunt", "Clamperl", "Luvdisc", "Sharpedo", "Wailmer", "Huntail", "Gorebyss", "Gyarados", "Wailord", "Relicanth"}  
		-- johto region
        	elseif townName == "New Bark" or townName == "Cherrygrove" or townName == "Violet" or townName == "Azalea" or townName == "Goldenrod" or townName == "Ecruteak" or townName == "Olivine" or townName == "Cianwood" or townName == "Mahogany" or townName == "Blackthorn" then
        		monsterTrash = {"Magikarp", "Remoraid"}
        		monsterVeryCommon = {"Magikarp", "Shellder", "Remoraid", "Corsola"}
        		monsterCommon = {"Magikarp", "Shellder", "Remoraid", "Chinchou", "Corsola"}
        		monsterMildRare = {"Magikarp", "Shellder", "Remoraid", "Chinchou", "Corsola", "Octillery", "Cloyster"}
        		monsterRare = {"Magikarp", "Shellder", "Remoraid", "Chinchou", "Corsola", "Octillery", "Cloyster", "Lanturn"}
        		monsterVeryRare = {"Magikarp", "Shellder", "Remoraid", "Chinchou", "Corsola", "Octillery", "Qwilfish", "Cloyster", "Lanturn"}
        		monsterUltraRare = {"Magikarp", "Shellder", "Remoraid", "Chinchou", "Corsola", "Octillery", "Qwilfish", "Cloyster", "Lanturn", "Gyarados"}          
        	end
	else
        	monsterVeryRare = monsterRare
        	monsterUltraRare = monsterRare
	end
        
	if math.random(1, 100) <= math.min(math.max(10 + (player:getEffectiveSkillLevel(SKILL_FISHING) - 10) * 0.597, 10), 50) then
		if useWorms and not player:removeItem("worm", 1) then
			return true
		end

		local name = "Magikarp"

		if player:getSkillLevel(SKILL_FISHING) < 8 then
			name = monsterTrash[math.random(#monsterTrash)]
		elseif player:getSkillLevel(SKILL_FISHING) >= 8 and player:getSkillLevel(SKILL_FISHING) < 20 then
			name = monsterVeryCommon[math.random(#monsterVeryCommon)]
		elseif player:getSkillLevel(SKILL_FISHING) >= 20 and player:getSkillLevel(SKILL_FISHING) < 30 then
			name = monsterCommon[math.random(#monsterCommon)]
		elseif player:getSkillLevel(SKILL_FISHING) >= 30 and player:getSkillLevel(SKILL_FISHING) < 45 then
			name = monsterMildRare[math.random(#monsterMildRare)]
		elseif player:getSkillLevel(SKILL_FISHING) >= 45 and player:getSkillLevel(SKILL_FISHING) < 60 then
			name = monsterRare[math.random(#monsterRare)]
		elseif player:getSkillLevel(SKILL_FISHING) >= 60 and player:getSkillLevel(SKILL_FISHING) < 75 then
			name = monsterVeryRare[math.random(#monsterVeryRare)]
		elseif player:getSkillLevel(SKILL_FISHING) >= 75 then
			name = monsterUltraRare[math.random(#monsterUltraRare)]
		end

		local monsterType = MonsterType(name)
		if math.random(1, 100) <= shinyChance then
			if monsterType:hasShiny() > 0 then
				name = "Shiny " .. name
				local shinyMonsterType = MonsterType(name)
				if not shinyMonsterType then
					print("WARNING! " .. name .. " not found for respawn.")
					return false
				end
			end
		end

		Game.createMonster(name, player:getClosestFreePosition(player:getPosition()))

		if targetId == 15401 then
			target:transform(targetId + 1)
			target:decay()
		elseif targetId == 7236 then
			target:transform(targetId + 1)
			target:decay()
		end
	end
	return true
end

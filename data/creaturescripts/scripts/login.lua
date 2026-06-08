function onLogin(player)
	local loginStr = "Bem vindo ao " .. configManager.getString(configKeys.SERVER_NAME) .. "!"
	if player:getLastLoginSaved() <= 0 then
		loginStr = loginStr .. " Please choose your outfit."
		player:sendOutfitWindow()
		player:enableAutoLoot()
	else
		if loginStr ~= "" then
			player:sendTextMessage(MESSAGE_STATUS_DEFAULT, loginStr)
		end

		loginStr = string.format("Sua ultima visita foi em %s.", os.date("%a %b %d %X %Y", player:getLastLoginSaved()))
	end
	player:sendTextMessage(MESSAGE_STATUS_DEFAULT, loginStr)

	-- Stamina
	nextUseStaminaTime[player.uid] = 0

	-- Promotion
	local vocation = player:getVocation()
	local promotion = vocation:getPromotion()
	if player:isPremium() then
		local value = player:getStorageValue(STORAGEVALUE_PROMOTION)
		if not promotion and value ~= 1 then
			player:setStorageValue(STORAGEVALUE_PROMOTION, 1)
		elseif value == 1 then
			player:setVocation(promotion)
		end
	elseif not promotion then
		player:setVocation(vocation:getDemotion())
	end

	-- Events
	player:registerEvent("PlayerDeath")
	player:registerEvent("DropLoot")
	player:registerEvent("MonsterHealthChange")

	-- Update questlog
	player:updateQuestLog()

	-- Refresh Pokemon Bar
	player:refreshPokemonBar({}, {})

	-- Check fly
--	if player:getStorageValue(storageFly) > 0 or player:getStorageValue(storageSurf) > 0 or player:getStorageValue(storageDive) > 0 then
--		player:setStorageValue(storageFly, -1)
--		player:setStorageValue(storageSurf, -1)
--		player:setStorageValue(storageDive, -1)
--		print("check 14")
--		player:teleportTo(player:getTown():getTemplePosition())
--		print("check 15")
--	end

	
	if player:isOnSurf() then -- Check surf
		local totalSpeed = player:getStorageValue(storageLogoutSpeed) or 50
		if totalSpeed < 50 then totalSpeed = 50 end
		player:changeSpeed(-player:getSpeed() + totalSpeed)
	elseif player:isOnRide() then -- Check ride
		local summonName = player:getSummonNameFromBall()
		local monsterType = MonsterType(summonName)
		if monsterType and monsterType:isRideable() > 0 then
			local totalSpeed = player:getStorageValue(storageLogoutSpeed) or 50
			if totalSpeed < 50 then totalSpeed = 50 end
			player:changeSpeed(-player:getSpeed() + totalSpeed)
			doChangeOutfit(player:getId(), {lookType = monsterType:isRideable()})
		else
			print("WARNING! Player " .. player:getName() .. " summonName not found onLogin for ride!")
			player:setStorageValue(storageRide, -1)
			player:teleportTo(player:getTown():getTemplePosition())
		end		
	elseif player:isOnFly() then -- Check fly
		local summonName = player:getSummonNameFromBall()
		local monsterType = MonsterType(summonName)
		if monsterType and monsterType:isFlyable() > 0 then
			local totalSpeed = player:getStorageValue(storageLogoutSpeed) or 50
			if totalSpeed < 50 then totalSpeed = 50 end
			player:changeSpeed(-player:getSpeed() + totalSpeed)
			doChangeOutfit(player:getId(), {lookType = monsterType:isFlyable()})
			player:activateFly()
		else
			print("WARNING! Player " .. player:getName() .. " summonName not found onLogin for fly!")
			player:setStorageValue(storageFly, -1)
			player:teleportTo(player:getTown():getTemplePosition())
		end
	elseif player:isOnDive() then -- Check dive
		doChangeOutfit(player:getId(), {lookType = 267})
	end

	-- Check evo
	if player:getStorageValue(storageEvolving) == 1 then
		player:setStorageValue(storageEvolving, -1)
		print("WARNING! Player " .. player:getName() .. " got problems while evolving summon.")
	end

	-- Check events
	if player:isOnEvent() then
		player:setStorageValue(storageEvent, -1)
		print("WARNING! Player " .. player:getName() .. " left event.")
	end

	-- Check duel
	if player:isDuelingWithNpc() then
		player:unsetDuelWithNpc()
	end

	-- Check league
	if player:isOnLeague() then
		player:setOutLeague()
		player:teleportTo(player:getTown():getTemplePosition())
		print("WARNING! Player " .. player:getName() .. " left league.")
	end

	-- Check slots
	player:addSlotItems()

	-- No pokes are being used
--	local balls = player:getPokeballs()
--	for i = 1, #balls do
--		local ball = balls[i]
--		ball:setSpecialAttribute("isBeingUsed", 0)
--	end

	-- Check if there are pokes in ammo slot and portrait
	local item = player:getSlotItem(CONST_SLOT_AMMO)
	if item then
		local depot = player:getInbox()
		addBall = item:moveTo(depot)
		if not addBall then
			print("WARNING! Player " .. player:getName() .. " had problems sending ball from ammo to cp.")
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your Pokemon was sent to CP.")
		end
	end
	local portrait = player:getSlotItem(CONST_SLOT_HEAD)
	if portrait then
		removePortrait = player:removeItem(portrait:getId(), 1)
		if not removePortrait then
			print("WARNING! Player " .. player:getName() .. " had problems removing portrait from head.")
		end
	end

	if not monstersTable then
		buildDex()
	end

	-- Check bug quest Oak
--	if player:getStorageValue(quests.cathemAll.prizes[1].uid) == 2 then
--		local catchRemainTable = {}
--		for i = 1, 386 do
--			if not isInArray(legendaryIndex, i) then 
--				table.insert(catchRemainTable, i)
--			end
--		end
--		if player:getCatchRemainNumber(catchRemainTable) > 0 then
--			print("WARNING! Player " .. player:getName() .. " bugou quest Professor Oak!!")
--		end
--	end

	-- Announces
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Welcome to PokeGypt v1.0")

	return true
end

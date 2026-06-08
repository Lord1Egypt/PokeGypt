local initialLevel = 1
local initialBoost = 0
local multiplierExpFirstNormal = 800
local multiplierExpNormal = 200
local multiplierExpFirstShiny = 3000
local multiplierExpShiny = 1000

local function doPlayerSendEffect(cid, effect)
	local player = Player(cid)
	if player then
		player:getPosition():sendMagicEffect(effect)
	end
	return true
end

local function doPlayerAddExperience(cid, exp)
	local player = Player(cid)
	if player then
		player:addExperience(exp, true)
	end
	return true
end

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local tile = Tile(toPosition)
	if not tile or not tile:getTopDownItem() or not ItemType(tile:getTopDownItem():getId()):isCorpse() then
		return false
	end
	local targetCorpse = tile:getTopDownItem()

	local owner = targetCorpse:getAttribute(ITEM_ATTRIBUTE_CORPSEOWNER)
	if owner ~= 0 and owner ~= player:getId() then
		player:sendCancelMessage("Sorry, not possible. You are not the owner.")
		return true
	end
	
	local ballKey = getBallKey(item:getId())
	local playerPos = getPlayerPosition(player)
	local d = getDistanceBetween(playerPos, toPosition)
	local delay = d * 80
	local delayMessage = delay + 2800
	local name = targetCorpse:getName()
	if name == "dead human" then		
		playerPos:sendMagicEffect(CONST_ME_POFF)
		return false
	end
	if name == "dead enlightened of the cult" then
		name = "enlightened of the cult"
	elseif name == "slain undead dragon" then
		name = "undead dragon"
	else
		name = string.gsub(name, "the ", "")
		name = string.gsub(name, "remains of ferumbras", "Ferumbras")
		name = string.gsub(name, "remains of", "")
		name = string.gsub(name, " a ", "")
		name = string.gsub(name, " an ", "")
		name = string.gsub(name, "slain ", "")
		name = string.gsub(name, "fainted ", "")
		name = string.gsub(name, "defeated ", "")
--		name = string.gsub(name, "dead ", "")
	end

	local monsterType = MonsterType(name)
	if not monsterType then
		print("WARNING! Monster " .. name .. " with bug on catch!")
		player:sendCancelMessage("Sorry, not possible. This problem was reported.")
		return true
	end
	local chance = monsterType:catchChance() * balls[ballKey].chanceMultiplier
	if player:getVocation():getName() == "Catcher" then
		chance = chance * catcherCatchBuff
	end
	if chance == 0 then
		playerPos:sendMagicEffect(CONST_ME_POFF)
		player:sendCancelMessage("Sorry, it is impossible to catch this monster.")
		return true
	end
	local monsterNumber = monsterType:getNumber()
	local storageCatch = baseStorageCatches + monsterNumber
	local storageTry = baseStorageTries + monsterNumber
	local level = targetCorpse:getSpecialAttribute("corpseLevel") or initialLevel
	doSendDistanceShoot(playerPos, toPosition, balls[ballKey].missile)
	item:remove(1)
	targetCorpse:remove()
	if player:getStorageValue(storageTry) < 0 then
		player:setStorageValue(storageTry, 1)
	else
		player:setStorageValue(storageTry, player:getStorageValue(storageTry) + 1)
	end
	if math.random(1, 300) <= chance then -- caught
		-- check how many pokeballs the player has
		if player:getSlotItem(CONST_SLOT_BACKPACK) and player:getSlotItem(CONST_SLOT_BACKPACK):getEmptySlots() >= 1 and player:getFreeCapacity() >= 1 then -- add to backpack
			addEvent(doAddPokeball, delayMessage, player:getId(), name, level, initialBoost, ballKey, false, delayMessage)
		else -- send to cp
			local addPokeball = doAddPokeball(player:getId(), name, level, initialBoost, ballKey, true, delayMessage + 4000)
			if not addPokeball then
				print("ERROR! Player " .. player:getName() .. " lost pokemon " .. name .. "! addPokeball false")
			end
			addEvent(doPlayerSendTextMessage, delayMessage + 2000, player:getId(), MESSAGE_EVENT_ADVANCE, "Since you are at maximum capacity, your ball was sent to CP.")
		end
		
		local playerLevel = player:getLevel()
		local maxExp = getNeededExp(playerLevel + 2) - getNeededExp(playerLevel)
		local maxExpShiny = getNeededExp(playerLevel + 5) - getNeededExp(playerLevel)

		local givenExp = monsterType:getExperience() * configManager.getNumber(configKeys.RATE_EXPERIENCE)
		if msgcontains(name, 'Shiny') and player:getStorageValue(storageCatch) == -1 then
			givenExp = givenExp * multiplierExpFirstShiny
			if givenExp > maxExpShiny then
				givenExp = maxExpShiny 
			end
			addEvent(doPlayerSendTextMessage, delayMessage + 1000, player:getId(), MESSAGE_EVENT_ADVANCE, "You got a bonus exp for your first catch of " .. name .. "!")
		elseif msgcontains(name, 'Shiny') and player:getStorageValue(storageCatch) > 0 then
			givenExp = givenExp * multiplierExpShiny
			if givenExp > maxExpShiny then
				givenExp = maxExpShiny 
			end
			addEvent(doPlayerSendTextMessage, delayMessage + 1000, player:getId(), MESSAGE_EVENT_ADVANCE, "You got a bonus exp for catching a shiny!")
		elseif not msgcontains(name, 'Shiny') and player:getStorageValue(storageCatch) == -1 then
			givenExp = givenExp * multiplierExpFirstNormal
			if givenExp > maxExp then
				givenExp = maxExp
			end
			addEvent(doPlayerSendTextMessage, delayMessage + 1000, player:getId(), MESSAGE_EVENT_ADVANCE, "You got a bonus exp for your first catch of " .. name .. "!")
		else
			givenExp = givenExp * multiplierExpNormal
			if givenExp > maxExp then
				givenExp = maxExp
			end

		end

		if player:getStorageValue(storageCatch) == -1 then
			player:setStorageValue(storageCatch, 1)
		else
			player:setStorageValue(storageCatch, player:getStorageValue(storageCatch) + 1)
		end

		addEvent(doPlayerAddExperience, delayMessage, player:getId(), givenExp)
		addEvent(doSendMagicEffect, delay, toPosition, balls[ballKey].effectSucceed)
		addEvent(doPlayerSendTextMessage, delayMessage, player:getId(), MESSAGE_EVENT_ADVANCE, "Congratulations! You have caught a " .. name .. "!")
		addEvent(doPlayerSendEffect, delayMessage, player:getId(), 297)
	else -- missed		
		addEvent(doSendMagicEffect, delay, toPosition, balls[ballKey].effectFail)
		addEvent(doPlayerSendEffect, delayMessage, player:getId(), 286)
		return true
	end	

	return true
end

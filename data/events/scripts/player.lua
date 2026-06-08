function Player:onBrowseField(position)
	return true
end

function Player:onLook(thing, position, distance)
	local description = "You see " .. thing:getDescription(distance)
	if not thing:isItem() and isSummon(thing) then
		local master = thing:getMaster()
		if master:isPlayer() then
			local item = master:getUsingBall()
			local pokeName = item:getSpecialAttribute("pokeName")
			local pokeLevel = item:getSpecialAttribute("pokeLevel")
			local pokeBoost = item:getSpecialAttribute("pokeBoost") or 0
			local pokeLove = item:getSpecialAttribute("pokeLove") or 0
			if pokeName ~= nil and pokeLevel ~= nil then			
				description = string.format("%s\nIt belongs to %s. Level: %s. Boost: +%s. Health: %s. Attack: %s. Magic Attack: %s. Magic Defense: %s. Armor: %s. Speed: %s.\n Love: %s.", description, master:getName(), pokeLevel, pokeBoost, thing:getTotalHealth(), thing:getTotalMeleeAttack(), thing:getTotalMagicAttack(), thing:getTotalMagicDefense(), thing:getTotalDefense(), thing:getTotalSpeed(), pokeLove)
			end
		end
	end
	if thing:isItem() and thing:isPokeball() then
		local pokeName = thing:getSpecialAttribute("pokeName")
		local pokeLevel = thing:getSpecialAttribute("pokeLevel")
		local pokeBoost = thing:getSpecialAttribute("pokeBoost") or 0
		local pokeLove = thing:getSpecialAttribute("pokeLove") or 0
		local ownerName = thing:getSpecialAttribute("owner")
		local pokeHealth = tonumber(thing:getSpecialAttribute("pokeHealth")) or 0
		local healthStr = ""
		if ownerName then
			healthStr = "It belongs to " .. ownerName .. "."
		end
		if pokeHealth <= 0 then
			healthStr = "It is fainted."
		end
		if pokeName ~= nil and pokeLevel ~= nil and healthStr ~= nil then			
			description = string.format("%s\nIt contains a %s. Level: %s. Boost: +%s. %s", description, pokeName, pokeLevel, pokeBoost, healthStr)
		end
	end
	if thing:isPlayer() and thing ~= self then
		if thing:getAccountType() == ACCOUNT_TYPE_TUTOR then
			if thing:getSex() == PLAYERSEX_MALE then
				description = string.format("%s He is a Tutor.", description)
			else
				description = string.format("%s She is a Tutor.", description)
			end
		end
	end
	if thing:isPlayer() and thing == self then
		if thing:getAccountType() == ACCOUNT_TYPE_TUTOR then
			description = string.format("%s You are a Tutor.", description)
		end
	end
	if self:getGroup():getAccess() then
		if thing:isItem() then
			description = string.format("%s\nItem ID: %d", description, thing:getId())

			local actionId = thing:getActionId()
			if actionId ~= 0 then
				description = string.format("%s, Action ID: %d", description, actionId)
			end

			local uniqueId = thing:getAttribute(ITEM_ATTRIBUTE_UNIQUEID)
			if uniqueId > 0 and uniqueId < 65536 then
				description = string.format("%s, Unique ID: %d", description, uniqueId)
			end

			local itemType = thing:getType()
			local transformEquipId = itemType:getTransformEquipId()
			local transformDeEquipId = itemType:getTransformDeEquipId()
			if transformEquipId ~= 0 then
				description = string.format("%s\nTransforms to: %d (onEquip)", description, transformEquipId)
			elseif transformDeEquipId ~= 0 then
				description = string.format("%s\nTransforms to: %d (onDeEquip)", description, transformDeEquipId)
			end

			local decayId = itemType:getDecayId()
			if decayId ~= -1 then
				description = string.format("%s\nDecays to: %d", description, decayId)
			end
		elseif thing:isCreature() then
			local str = "%s\nHealth: %d / %d"
			if thing:getMaxMana() > 0 then
				str = string.format("%s, Mana: %d / %d", str, thing:getMana(), thing:getMaxMana())
			end
			description = string.format(str, description, thing:getHealth(), thing:getMaxHealth()) .. "."
		end

		if thing:isCreature() then
			if thing:isPlayer() then
				description = string.format("%s\nIP: %s.", description, Game.convertIpToString(thing:getIp()))
			end
		end
	end
	if self:getAccountType() >= ACCOUNT_TYPE_TUTOR then
		local position = thing:getPosition()
		description = string.format(
			"%s\nPosition: %d, %d, %d",
			description, position.x, position.y, position.z
		)
	end
	self:sendTextMessage(MESSAGE_INFO_DESCR, description)
end

function Player:onLookInBattleList(creature, distance)
	local description = "You see " .. creature:getDescription(distance)
	if isSummon(creature) then
		local master = creature:getMaster()
--		local item = master:getSlotItem(CONST_SLOT_AMMO)
--		local pokeName = item:getSpecialAttribute("pokeName")
--		local pokeLevel = item:getSpecialAttribute("pokeLevel")
		local pokeName = master:getName()
		local pokeLevel = creature:getLevel()
		if pokeName ~= nil and pokeLevel ~= nil then			
			description = string.format("%s\nIt belongs to %s. Level: %s.", description, master:getName(), pokeLevel)
		end
	end
	if self:getGroup():getAccess() then
		local str = "%s\nHealth: %d / %d"
		if creature:getMaxMana() > 0 then
			str = string.format("%s, Mana: %d / %d", str, creature:getMana(), creature:getMaxMana())
		end
		description = string.format(str, description, creature:getHealth(), creature:getMaxHealth()) .. "."

		local position = creature:getPosition()
		description = string.format(
			"%s\nPosition: %d, %d, %d",
			description, position.x, position.y, position.z
		)

		if creature:isPlayer() then
			description = string.format("%s\nIP: %s", description, Game.convertIpToString(creature:getIp()))
		end
	end
	self:sendTextMessage(MESSAGE_INFO_DESCR, description)
end

function Player:onLookInTrade(partner, item, distance)
	local description = "You see " .. item:getDescription(distance)
	if item:isPokeball() then
		local pokeName = item:getSpecialAttribute("pokeName")
		local pokeLevel = item:getSpecialAttribute("pokeLevel")
		local pokeBoost = item:getSpecialAttribute("pokeBoost") or 0
		local pokeLove = item:getSpecialAttribute("pokeLove") or 0
		local pokeHealth = tonumber(item:getSpecialAttribute("pokeHealth"))
		local healthStr = ""
		if pokeHealth <= 0 then
			healthStr = "It is fainted."
		end
		if pokeName ~= nil and pokeLevel ~= nil and healthStr ~= nil then			
			description = string.format("%s\nIt contains a %s. Level: %s. Boost: +%s. Love: +%s. %s", description, pokeName, pokeLevel, pokeBoost, pokeLove, healthStr)
		end
	end
	self:sendTextMessage(MESSAGE_INFO_DESCR, description)
end

function Player:onLookInShop(itemType, count)
	return true
end

function Player:onMoveItem(item, count, fromPosition, toPosition, fromCylinder, toCylinder)
	if item:getId() == 2270 or item:getId() == 2263 or item:getId() == 8922 then self:sendCancelMessage("Sorry, not possible.") return false end
	if item:getId() == 27634 and toPosition.x ~= 65535 and self:getStorageValue(storageBike) > 0 then self:sendCancelMessage("Sorry, not possible.") return false end
	if item:getId() == 26749 then
		print("WARNING! Player " .. self:getName() .. " moving ancient stone!")
	end
	if fromPosition.x == 65535 and fromPosition.y == 10 or (toPosition.x == 65535 and toPosition.y == 10) and item:isPokeball() then 
		if self:getStorageValue(storageFly) == 1 then
			self:sendCancelMessage("Sorry, not possible while on fly.")
			return false
		end
		if self:getStorageValue(storageSurf) > 0 then
			self:sendCancelMessage("Sorry, not possible while on surf.")
			return false
		end
		if self:getStorageValue(storageRide) > 0 then
			self:sendCancelMessage("Sorry, not possible while on ride.")
			return false
		end
		local summon = self:getSummon()
		if summon and summon:isEvolving() then
			self:sendCancelMessage("Sorry, not possible. Your summon is evolving.")
			return false
		end
	end
	if fromPosition.x == 65535 and fromPosition.y == 10 and item:isPokeball() then
		local pokeName = item:getSpecialAttribute("pokeName")
		local monsterType = MonsterType(pokeName)
		local portraitId = monsterType:portraitId()
		if portraitId == 0 then return true end
		local putPortrait = self:removeItem(portraitId)
		if not putPortrait then
			print("WARNING! Problem on remove portrait player events " .. pokeName .. " player " .. self:getName())
		end	
	end

	if self:isDuelingWithNpc() and item:isPokeball() and toPosition.x == 65535 and fromPosition.x ~= 65535 then
		self:sendCancelMessage("Sorry, not possible while in duel.")
		return false
	end

--	if toPosition.x ~= 65535 or (toPosition.x == 65535 and toPosition.y ~= 64 and toPosition.y ~= 3 and toPosition.y ~= 10) then
		if item:isPokeball() then
			local isBallBeingUsed = item:getSpecialAttribute("isBeingUsed")
			if isBallBeingUsed and isBallBeingUsed == 1 then
				self:sendCancelMessage("Sorry, not possible while using Pokemon.")
				return false
			end
		elseif item:isContainer() then
			local balls = item:getPokeballs()
			for i = 1, #balls do
				local isBallBeingUsed = balls[i]:getSpecialAttribute("isBeingUsed")
				if isBallBeingUsed and isBallBeingUsed == 1 then
					self:sendCancelMessage("Sorry, not possible while using Pokemon.")
					return false
				end
			end
		end
--	end

	return true
end

function Player:onItemMoved(item, count, fromPosition, toPosition, fromCylinder, toCylinder)
	if item:isPokeball() or item:isContainer() then
		self:refreshPokemonBar({}, {})
	end
end

function Player:onMoveCreature(creature, fromPosition, toPosition)
	return true
end

function Player:onTurn(direction)
	if hasSummons(self) then
		local summon = self:getSummons()[1]
		local summonDirection = summon:getDirection()
		if summonDirection == direction then return true end
--		local msg = summon:getName() .. "! Turn to "
--		if direction == 0 then msg = msg .. "north." end
--		if direction == 1 then msg = msg .. "east." end
--		if direction == 2 then msg = msg .. "south." end
--		if direction == 3 then msg = msg .. "west." end
		summon:setDirection(direction)
		summon:setIdle(6000)
--		self:say(msg, TALKTYPE_SAY)
	end
	return true
end

function Player:onTradeRequest(target, item)
	if self:isDuelingWithNpc() and item:isPokeball() then
		self:sendCancelMessage("Sorry, not possible while in duel.")
		return false
	end
	if item:isPokeball() then
		if item:isBeingUsed() then
			self:sendCancelMessage("Sorry, not possible while using pokeball.")
			return false
		end
	end
	if item:isContainer() then
		local pokeballs = item:getPokeballs()
		for i = 1, #pokeballs do
			if pokeballs[i]:isBeingUsed() then
				self:sendCancelMessage("Sorry, not possible while using pokeball.")
				return false
			end
		end
	end
	return true
end

function Player:onTradeAccept(target, item, targetItem)
	self:refreshPokemonBar({}, {})
	target:refreshPokemonBar({}, {})
	return true
end

local soulCondition = Condition(CONDITION_SOUL, CONDITIONID_DEFAULT)
soulCondition:setTicks(4 * 60 * 1000)
soulCondition:setParameter(CONDITION_PARAM_SOULGAIN, 1)

local function useStamina(player)
	local staminaMinutes = player:getStamina()
	if staminaMinutes == 0 then
		return
	end

	local playerId = player:getId()
	local currentTime = os.time()
	if nextUseStaminaTime[playerId] == nil then
		return
	end
	local timePassed = currentTime - nextUseStaminaTime[playerId]
	if timePassed <= 0 then
		return
	end

	if timePassed > 60 then
		if staminaMinutes > 2 then
			staminaMinutes = staminaMinutes - 2
		else
			staminaMinutes = 0
		end
		nextUseStaminaTime[playerId] = currentTime + 120
	else
		staminaMinutes = staminaMinutes - 1
		nextUseStaminaTime[playerId] = currentTime + 60
	end
	player:setStamina(staminaMinutes)
end

function Player:onGainExperience(source, exp, rawExp)
	local multiplier = 3 -- how many times more exp than players a monster will get

	if not source then
		return exp
	end

	-- Soul regeneration
	local vocation = self:getVocation()
	if self:getSoul() < vocation:getMaxSoul() and exp >= self:getLevel() then
		soulCondition:setParameter(CONDITION_PARAM_SOULTICKS, vocation:getSoulGainTicks() * 1000)
		self:addCondition(soulCondition)
	end

	-- Apply experience stage multiplier
	exp = exp * Game.getExperienceStage(self:getLevel())

	-- Stamina modifier
	if configManager.getBoolean(configKeys.STAMINA_SYSTEM) then
		useStamina(self)

		local staminaMinutes = self:getStamina()
		if staminaMinutes > 2400 and self:isPremium() then
			exp = exp * 1.5
		elseif staminaMinutes <= 840 then
			exp = exp * 0.5
		end
	end

	-- Update questlog
	if exp + self:getExperience() >= getNeededExp(self:getLevel() + 1) then
		self:updateQuestLog()
	end

	-- Vocation buff
	if vocation:getName() == "Explorer" then
		exp = exp * explorerExperienceBuff
	end

	if hasSummons(self) then
		local creature = self:getSummon()
--		local item = self:getSlotItem(CONST_SLOT_AMMO)
		local item = self:getUsingBall()
		if item and item:isPokeball() then
			local level = item:getSpecialAttribute("pokeLevel") or 1
			if level >= summonMaxLevel then
				return exp
			end
			local givenExp = exp * multiplier
			if vocation:getName() == "Explorer" then
				givenExp = math.floor(givenExp / explorerExperienceBuff)
			end
			local summonPos = creature:getPosition()
			local pokeExp = item:getSpecialAttribute("pokeExperience") or 0
			local nextLevel = level + 1
			local newExp = pokeExp + givenExp
			item:setSpecialAttribute("pokeExperience", newExp)
			if givenExp > 0 then 
				summonPos:sendAnimatedNumber(MESSAGE_EXPERIENCE_OTHERS, "Your summon gained " .. givenExp .. " experience points.", givenExp, TEXTCOLOR_WHITE_EXP)
			end
			if newExp > getNeededExp(nextLevel)  then				
				item:setSpecialAttribute("pokeLevel", nextLevel)
				local love = item:getSpecialAttribute("pokeLove") or 0
				local newMaxHealth = creature:getTotalHealth()
				creature:setMaxHealth(newMaxHealth)
				creature:changeSpeed(-creature:getSpeed() + creature:getTotalSpeed())			
				creature:setHealth(newMaxHealth)
				summonPos:sendMagicEffect(CONST_ME_HEARTS)
				
				if MonsterType(source:getName()):isLegendary() then 
					love = love + 3
				elseif level < source:getLevel() then
					love = love + 2					
				else
					love = love + 1
				end

				item:setSpecialAttribute("pokeLove", love)
				doRemoveSummon(self:getId(), false, nil, false)
				item:setSpecialAttribute("isBeingUsed", 1)
				local cid = doReleaseSummon(self:getId(), summonPos, false, false)

				if not cid then
					print("WARNING! Creature " .. creature:getName() .. ", level " .. nextLevel .. " from player " .. self:getName() .. " with problems on change level.")
				end

				local summonName = creature:getName()
				local monsterType = MonsterType(summonName)
				local statusGain = statusGainFormula(0, nextLevel, 0, 0) - statusGainFormula(0, level, 0, 0)
				self:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Congratulations! Your pokemon evolved to level " .. nextLevel .. ".\nStatus bonus:\nHealth: " .. monsterType:getMaxHealth() * statusGain .. "\nAttack: " .. monsterType:getMeleeDamage() * statusGain .. "\nMagic Attack: " .. monsterType:getMoveMagicAttackBase() * statusGain .. "\nMagic Defense: " .. monsterType:getMoveMagicDefenseBase() * statusGain .. "\nDefense: " .. monsterType:getDefense() * statusGain .. "\nSpeed: " .. monsterType:getBaseSpeed() * statusGain)
				self:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Your pokemon gained " .. love .. " love points.")

				local dittoTime = item:getSpecialAttribute("dittoTime")
				if not dittoTime then
					local evolutionList = monsterType:getEvolutionList()				
					if #evolutionList >= 1 and not creature:isEvolving() then				
						for i = 1, #evolutionList do					
							local evolution = evolutionList[i]
							local evolutionName = evolution.name
							if evolutionName ~= "" then
								local evolutionLevel = evolution.level
								if nextLevel >= evolution.level and math.random(1, 100) <= evolution.chance then
									doEvolveSummon(cid, evolutionName)
								end
							end
						end
					end
				end
			else
				self:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Your summon gained " .. givenExp .. " experience points. Needs " .. getNeededExp(nextLevel) - newExp .. " to level " .. nextLevel .. ".")
			end
		end
	end
	return exp
end

function Player:onLoseExperience(exp)
	return exp
end

function Player:onGainSkillTries(skill, tries)
	if APPLY_SKILL_MULTIPLIER == false then
		return tries
	end

	if skill == SKILL_MAGLEVEL then
		return tries * configManager.getNumber(configKeys.RATE_MAGIC)
	end
	return tries * configManager.getNumber(configKeys.RATE_SKILL)
end

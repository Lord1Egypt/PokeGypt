function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not hasSummons(player) then
		player:sendCancelMessage("Sorry, not possible. You need a summon to evolve.")
		return true
	end

	if not target:isCreature() then
		player:sendCancelMessage("Sorry, not possible. You can only evolve summons.")
		return true
	end

	if target:isCreature() then
		if target:isPlayer() then
			player:sendCancelMessage("Sorry, not possible. You can only evolve summons.")
			return true
		elseif target ~= player:getSummon() then 
			player:sendCancelMessage("Sorry, not possible. You can only evolve your own summon.")
			return true
		end
	end

	if target:isEvolving() then
		player:sendCancelMessage("Sorry, not possible. Your summon is already evolving.")
		return true
	end

	local ball = player:getUsingBall()
	if not ball then return true end

	local dittoTime = ball:getSpecialAttribute("dittoTime")
	if dittoTime and os.time() < dittoTime then
		player:sendCancelMessage("Sorry, not possible. You can not evolve your Pokemon while transformed.")
		return true
	end
	
	local summonName = target:getName()
	local monsterType = MonsterType(summonName)
	if not monsterType then
		print("WARNING! Monster " .. summonName .. " with bug on evolution!")
		player:sendCancelMessage("Sorry, not possible. This problem was reported.")
		return true
	end
	local evolutionList = monsterType:getEvolutionList()
	if #evolutionList >= 1 then
		for i = 1, #evolutionList do
			local evolution = evolutionList[i]
			local evolutionName = evolution.name
			if evolutionName ~= "" then
				local itemType = ItemType(evolution.itemName)
				if itemType and itemType:getId() == item:getId() then
					local isAncient = false
					if item:getName() == "unique ancient stone" then
						if player:getStorageValue(storageEvolutionAncient) > 0 then
							player:sendCancelMessage("Sorry, not possible. You can have only one ancient.")
							return true
						else
							isAncient = true						
						end
					end
					if player:removeItem(itemType:getId(), evolution.count) then
						doEvolveSummon(target:getId(), evolutionName, isAncient)
						return true
					else
						player:sendCancelMessage("Sorry, not possible. You do not have the necessary items to evolve this monster.")
						return true
					end
				end
			end
		end
	else
		player:sendCancelMessage("Sorry, not possible. You can not evolve this monster.")
		return true
	end
	return false
end

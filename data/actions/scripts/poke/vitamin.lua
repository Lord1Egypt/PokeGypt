local function getStatusName(itemId)
	local statusName
	if itemId == 38779 then
		statusName = "magicAttack"
	elseif itemId == 38780 then
		statusName = "speed"
	elseif itemId == 38781 then
		statusName = "hp"
	elseif itemId == 38782 then
		statusName = "defense"
	elseif itemId == 38783 then
		statusName = "ppMax"
	elseif itemId == 38784 then
		statusName = "ppUp"
	elseif itemId == 38785 then
		statusName = "attack"
	elseif itemId == 38786 then
		statusName = "magicDefense"
	elseif itemId == 38787 then
		statusName = "pokeLevel"
	end
	return statusName
end

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not target then
		return false
	end

	if type(target) ~= "userdata" then
		return true
	end

	if not target:isPokemon() then
		player:sendCancelMessage("Sorry, not possible. You must use in a Pokemon.")
		return true 
	end

	if player ~= target:getMaster() then
		player:sendCancelMessage("Sorry, not possible. You must use in your Pokemon.")
		return true 
	end

	local statusToBeIncreased = getStatusName(item:getId())
	if not statusToBeIncreased then
		print("WARNING! Problem on status increasing player " .. player:getName() .. " item " .. item:getName())
		return true
	end

	if statusToBeIncreased == "pokeLevel" then
		if target:getLevel() >= summonMaxLevel then
			player:sendCancelMessage("Sorry, not possible to feed this Pokemon anymore.")
		else
			player:say(target:getName() .. ", take this!", TALKTYPE_SAY)
			target:say("Hmm", TALKTYPE_SAY)
			target:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
			target:increaseStatus(statusToBeIncreased)
			item:remove(1)
		end
	else
		if target:increaseUsedVitaminsNumber() then
			player:say(target:getName() .. ", take this!", TALKTYPE_SAY)
			target:say("Hmm", TALKTYPE_SAY)
			target:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
			target:increaseStatus(statusToBeIncreased)
			item:remove(1)
		else
			player:sendCancelMessage("Sorry, not possible to feed this Pokemon anymore.")
		end
	end

	return true
end

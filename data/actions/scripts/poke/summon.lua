function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:isSummonBlocked() then return true end

	local ballKey = getBallKey(item:getId())

	if hasSummons(player) then
		local usingBall = player:getUsingBall()
		if usingBall ~= item then return true end
		doRemoveSummon(player:getId(), balls[ballKey].effectRelease, false, true, balls[ballKey].missile)
		item:transform(balls[ballKey].usedOn)
	else
		if item:getTopParent() == player then
			if player:canReleaseSummon(item:getSummonLevel(), item:getSummonBoost(), item:getSummonOwner()) then
				item:transform(balls[ballKey].usedOff)
				item:setSpecialAttribute("isBeingUsed", 1)
				doReleaseSummon(player:getId(), player:getPosition(), balls[ballKey].effectRelease, true, balls[ballKey].missile)
			end
		else
			if item:getSpecialAttribute("isBeingUsed") == 1 then --corrects the bug of players using balls that were not holding
				item:transform(balls[ballKey].usedOn)
				item:setSpecialAttribute("isBeingUsed", 0)
			end
		end
	end
	return true
end

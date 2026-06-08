function onSay(player, words, param)
	if player:isSummonBlocked() then return false end

	local index = tonumber(param)
	if not index then return false end

	local pokeballs = player:getPokeballs()
	local ball = pokeballs[index]
--	local ball = player:getSpecialStorage("pokes")[index]

	if not ball then
		print("WARNING! Player " .. player:getName() .. " had problems trying to use pokebar: selected ball not found.")
		player:refreshPokemonBar({}, {})
		return false
	end

	if player:canReleaseSummon(ball:getSummonLevel(), ball:getSummonBoost(), ball:getSummonOwner()) then
		if hasSummons(player) then
			local usingBall = player:getUsingBall()
			if not usingBall then
				print("WARNING! Player " .. player:getName() .. " had problems trying to use pokebar: doRemoveSummon.")
				player:refreshPokemonBar({}, {})
				return false
			end
			local usingBallKey = getBallKey(usingBall:getId())
			doRemoveSummon(player:getId(), balls[usingBallKey].effectRelease, false, true, balls[usingBallKey].missile)
			usingBall:transform(balls[usingBallKey].usedOn)
		end

		local ballKey = getBallKey(ball:getId())
		ball:transform(balls[ballKey].usedOff)
		ball:setSpecialAttribute("isBeingUsed", 1)
		doReleaseSummon(player:getId(), player:getPosition(), balls[ballKey].effectRelease, true, balls[ballKey].missile)
	end

	return false
end

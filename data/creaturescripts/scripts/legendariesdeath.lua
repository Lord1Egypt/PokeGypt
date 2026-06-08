local halloweenPrizes = 
{
	[1] = {
		name = "box 0",
		count = 1
	},
	[2] = {
		name = "box 1",
		count = 1
	},
	[3] = {
		name = "box 2",
		count = 1
	},
	[4] = {
		name = "box 3",
		count = 1
	},
	[5] = {
		name = "crystal coin",
		count = 10
	}
}

local christmasPrizes = 
{
	[1] = {
		name = "box 0",
		count = 1
	},
	[2] = {
		name = "box 1",
		count = 1
	},
	[3] = {
		name = "box 2",
		count = 1
	},
	[4] = {
		name = "box 3",
		count = 1
	},
	[5] = {
		name = "crystal coin",
		count = 10
	}
}

function onPrepareDeath(creature, killer)
	for cid, _ in pairs(creature:getDamageMap()) do
		local player = Player(cid)
		if player then
			if creature:getName() == "Mutated Pumpkin" then
				local index = math.random(1,4)
				player:addItem(halloweenPrizes[index].name, halloweenPrizes[index].count)
				player:addItem(halloweenPrizes[5].name, halloweenPrizes[5].count)
				local msg = "Parabens! Por ajudar a derrotar a abobora mutante voce ganhou " .. halloweenPrizes[index].count .. " " .. halloweenPrizes[index].name .. ", " .. halloweenPrizes[5].count .. " " .. halloweenPrizes[5].name
				if math.random(1, 100) <= 5 then
					player:addTokens(1)
					msg = msg .. " e 1 token!"
				else
					msg = msg .. "!"
				end
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, msg)
			end
			if creature:getName() == "Mutated Santa" then
				local index = math.random(1,4)
				player:addItem(christmasPrizes[index].name, christmasPrizes[index].count)
				player:addItem(christmasPrizes[5].name, christmasPrizes[5].count)
				local msg = "Parabens! Por ajudar a derrotar o papai noel mutante voce ganhou " .. christmasPrizes[index].count .. " " .. christmasPrizes[index].name .. ", " .. christmasPrizes[5].count .. " " .. christmasPrizes[5].name
				if math.random(1, 100) <= 40 then
					player:addTokens(1)
					msg = msg .. " e 1 token!"
				else
					msg = msg .. "!"
				end
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, msg)
			end
			player:setKilledLegendaryPokemon()
		end
	end
	return true
end

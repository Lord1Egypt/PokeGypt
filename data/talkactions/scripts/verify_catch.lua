local legendaryIndex = {144, 145, 146, 150, 151, 243, 244, 245, 249, 250, 251, 377, 378, 379, 380, 381, 382, 383, 384, 385, 386}

function onSay(player, words, param)
	local catchRemainTable = {}
	for i = 1, 386 do
		if not isInArray(legendaryIndex, i) then 
			table.insert(catchRemainTable, i)
		end
	end
	local catchRemain = player:getCatchRemain(catchRemainTable)
	if catchRemain == 0 then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Parabens, voce conseguiu capturar todos os Poemons de Kanto.")
	else
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Ainda faltam " .. catchRemain .. " para capturar todos os Pokemons de Kanto." )
	end

	return false
end

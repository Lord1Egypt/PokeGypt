local numberPremier = 0
local priceBags = 25

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	
	if msgcontains(msg, 'bye') or msgcontains(msg, 'no') or msgcontains(msg, 'nao') then
		selfSay('Talvez uma outra hora.', cid)
		npcHandler:releaseFocus(cid)
	elseif msgcontains(msg, 'sell') or msgcontains(msg, 'buy') or msgcontains(msg, 'comprar') or msgcontains(msg, 'vender') or msgcontains(msg, 'help') then
		selfSay('Ola, estou interessado em seus tokens, deseja troca-los por {premierball}s ou {bag}s ?', cid)
	elseif msgcontains(msg, 'premier') or msgcontains(msg, 'premierball') then
		selfSay('Quantos tokens deseja trocar por premierball?', cid)
		npcHandler.topic[cid] = 1
	elseif npcHandler.topic[cid] == 1 then
		numberPremier = tonumber(msg)
		if numberPremier and numberPremier > 0 then
			selfSay('Gostaria de trocar ' .. numberPremier .. ' tokens por ' .. numberPremier * 5 .. ' premierballs?', cid)
			npcHandler.topic[cid] = 2
		else
			selfSay('Quantos tokens deseja trocar por premierball?', cid)
		end
	elseif npcHandler.topic[cid] == 2 and (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) then
		local player = Player(cid)
		if player:removeTokens(numberPremier) then
			selfSay('Aqui estao suas premierballs. Volte sempre!', cid)
			player:addItem("empty premierball", numberPremier * 5)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		else
			selfSay('Voce nao possui todos esses tokens!', cid)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		end
	elseif msgcontains(msg, 'bag') or msgcontains(msg, 'bags') then
		selfSay('Possuo bags dos seguintes pokemons: {aerodactyl}, {charizard}, {chikorita}, {dragonite}, {eevee}, {espeon}, {flareon}, {golduck}, {haunter}, {jolteon}, {jynx}, {machamp}, {marowak}, {mr. mime}, {pidgeot}, {pikachu}, {sandslash}, {scyther}, {scizor}, {sneasel}, {snorlax}, {umbreon}, {vaporeon}, {victrebeel} e {wartortle}. Qual deseja?', cid)
	elseif msgcontains(msg, 'aerodactyl') then
		selfSay('Deseja trocar ' .. priceBags .. ' tokens por uma aerodactyl bag?', cid)
		npcHandler.topic[cid] = 4
	elseif npcHandler.topic[cid] == 4 and (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) then
		local player = Player(cid)
		if player:removeTokens(priceBags) then
			selfSay('Aqui esta sua bag. Volte sempre!', cid)
			player:addItem("aerodactyl bag", 1)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		else
			selfSay('Voce nao possui todos esses tokens!', cid)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		end
	elseif msgcontains(msg, 'charizard') then
		selfSay('Deseja trocar ' .. priceBags .. ' tokens por uma charizard bag?', cid)
		npcHandler.topic[cid] = 5
	elseif npcHandler.topic[cid] == 5 and (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) then
		local player = Player(cid)
		if player:removeTokens(priceBags) then
			selfSay('Aqui esta sua bag. Volte sempre!', cid)
			player:addItem("charizard bag", 1)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		else
			selfSay('Voce nao possui todos esses tokens!', cid)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		end
	elseif msgcontains(msg, 'chikorita') then
		selfSay('Deseja trocar ' .. priceBags .. ' tokens por uma chikorita bag?', cid)
		npcHandler.topic[cid] = 6
	elseif npcHandler.topic[cid] == 6 and (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) then
		local player = Player(cid)
		if player:removeTokens(priceBags) then
			selfSay('Aqui esta sua bag. Volte sempre!', cid)
			player:addItem("chikorita bag", 1)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		else
			selfSay('Voce nao possui todos esses tokens!', cid)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		end
	elseif msgcontains(msg, 'dragonite') then
		selfSay('Deseja trocar ' .. priceBags .. ' tokens por uma dragonite bag?', cid)
		npcHandler.topic[cid] = 7
	elseif npcHandler.topic[cid] == 7 and (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) then
		local player = Player(cid)
		if player:removeTokens(priceBags) then
			selfSay('Aqui esta sua bag. Volte sempre!', cid)
			player:addItem("dragonite bag", 1)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		else
			selfSay('Voce nao possui todos esses tokens!', cid)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		end
	elseif msgcontains(msg, 'eevee') then
		selfSay('Deseja trocar ' .. priceBags .. ' tokens por uma eevee bag?', cid)
		npcHandler.topic[cid] = 8
	elseif npcHandler.topic[cid] == 8 and (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) then
		local player = Player(cid)
		if player:removeTokens(priceBags) then
			selfSay('Aqui esta sua bag. Volte sempre!', cid)
			player:addItem("eevee bag", 1)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		else
			selfSay('Voce nao possui todos esses tokens!', cid)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		end
	elseif msgcontains(msg, 'espeon') then
		selfSay('Deseja trocar ' .. priceBags .. ' tokens por uma espeon bag?', cid)
		npcHandler.topic[cid] = 9
	elseif npcHandler.topic[cid] == 9 and (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) then
		local player = Player(cid)
		if player:removeTokens(priceBags) then
			selfSay('Aqui esta sua bag. Volte sempre!', cid)
			player:addItem("espeon bag", 1)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		else
			selfSay('Voce nao possui todos esses tokens!', cid)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		end
	elseif msgcontains(msg, 'flareon') then
		selfSay('Deseja trocar ' .. priceBags .. ' tokens por uma flareon bag?', cid)
		npcHandler.topic[cid] = 10
	elseif npcHandler.topic[cid] == 10 and (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) then
		local player = Player(cid)
		if player:removeTokens(priceBags) then
			selfSay('Aqui esta sua bag. Volte sempre!', cid)
			player:addItem("flareon bag", 1)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		else
			selfSay('Voce nao possui todos esses tokens!', cid)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		end
	elseif msgcontains(msg, 'golduck') then
		selfSay('Deseja trocar ' .. priceBags .. ' tokens por uma golduck bag?', cid)
		npcHandler.topic[cid] = 11
	elseif npcHandler.topic[cid] == 11 and (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) then
		local player = Player(cid)
		if player:removeTokens(priceBags) then
			selfSay('Aqui esta sua bag. Volte sempre!', cid)
			player:addItem("golduck bag", 1)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		else
			selfSay('Voce nao possui todos esses tokens!', cid)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		end
	elseif msgcontains(msg, 'haunter') then
		selfSay('Deseja trocar ' .. priceBags .. ' tokens por uma haunter bag?', cid)
		npcHandler.topic[cid] = 12
	elseif npcHandler.topic[cid] == 12 and (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) then
		local player = Player(cid)
		if player:removeTokens(priceBags) then
			selfSay('Aqui esta sua bag. Volte sempre!', cid)
			player:addItem("haunter bag", 1)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		else
			selfSay('Voce nao possui todos esses tokens!', cid)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		end
	elseif msgcontains(msg, 'jolteon') then
		selfSay('Deseja trocar ' .. priceBags .. ' tokens por uma jolteon bag?', cid)
		npcHandler.topic[cid] = 13
	elseif npcHandler.topic[cid] == 13 and (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) then
		local player = Player(cid)
		if player:removeTokens(priceBags) then
			selfSay('Aqui esta sua bag. Volte sempre!', cid)
			player:addItem("jolteon bag", 1)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		else
			selfSay('Voce nao possui todos esses tokens!', cid)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		end
	elseif msgcontains(msg, 'jynx') then
		selfSay('Deseja trocar ' .. priceBags .. ' tokens por uma jynx bag?', cid)
		npcHandler.topic[cid] = 14
	elseif npcHandler.topic[cid] == 14 and (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) then
		local player = Player(cid)
		if player:removeTokens(priceBags) then
			selfSay('Aqui esta sua bag. Volte sempre!', cid)
			player:addItem("jynx bag", 1)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		else
			selfSay('Voce nao possui todos esses tokens!', cid)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		end
	elseif msgcontains(msg, 'machamp') then
		selfSay('Deseja trocar ' .. priceBags .. ' tokens por uma machamp bag?', cid)
		npcHandler.topic[cid] = 15
	elseif npcHandler.topic[cid] == 15 and (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) then
		local player = Player(cid)
		if player:removeTokens(priceBags) then
			selfSay('Aqui esta sua bag. Volte sempre!', cid)
			player:addItem("machamp bag", 1)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		else
			selfSay('Voce nao possui todos esses tokens!', cid)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		end
	elseif msgcontains(msg, 'marowak') then
		selfSay('Deseja trocar ' .. priceBags .. ' tokens por uma marowak bag?', cid)
		npcHandler.topic[cid] = 16
	elseif npcHandler.topic[cid] == 16 and (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) then
		local player = Player(cid)
		if player:removeTokens(priceBags) then
			selfSay('Aqui esta sua bag. Volte sempre!', cid)
			player:addItem("marowak bag", 1)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		else
			selfSay('Voce nao possui todos esses tokens!', cid)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		end
	elseif msgcontains(msg, 'mr. mime') then
		selfSay('Deseja trocar ' .. priceBags .. ' tokens por uma mr. mime bag?', cid)
		npcHandler.topic[cid] = 17
	elseif npcHandler.topic[cid] == 17 and (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) then
		local player = Player(cid)
		if player:removeTokens(priceBags) then
			selfSay('Aqui esta sua bag. Volte sempre!', cid)
			player:addItem("mr. mime bag", 1)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		else
			selfSay('Voce nao possui todos esses tokens!', cid)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		end
	elseif msgcontains(msg, 'pidgeot') then
		selfSay('Deseja trocar ' .. priceBags .. ' tokens por uma pidgeot bag?', cid)
		npcHandler.topic[cid] = 18
	elseif npcHandler.topic[cid] == 18 and (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) then
		local player = Player(cid)
		if player:removeTokens(priceBags) then
			selfSay('Aqui esta sua bag. Volte sempre!', cid)
			player:addItem("pidgeot bag", 1)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		else
			selfSay('Voce nao possui todos esses tokens!', cid)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		end
	elseif msgcontains(msg, 'pikachu') then
		selfSay('Deseja trocar ' .. priceBags .. ' tokens por uma pikachu bag?', cid)
		npcHandler.topic[cid] = 19
	elseif npcHandler.topic[cid] == 19 and (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) then
		local player = Player(cid)
		if player:removeTokens(priceBags) then
			selfSay('Aqui esta sua bag. Volte sempre!', cid)
			player:addItem("pikachu bag", 1)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		else
			selfSay('Voce nao possui todos esses tokens!', cid)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		end
	elseif msgcontains(msg, 'sandslash') then
		selfSay('Deseja trocar ' .. priceBags .. ' tokens por uma sandslash bag?', cid)
		npcHandler.topic[cid] = 20
	elseif npcHandler.topic[cid] == 20 and (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) then
		local player = Player(cid)
		if player:removeTokens(priceBags) then
			selfSay('Aqui esta sua bag. Volte sempre!', cid)
			player:addItem("sandslash bag", 1)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		else
			selfSay('Voce nao possui todos esses tokens!', cid)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		end
	elseif msgcontains(msg, 'scyther') then
		selfSay('Deseja trocar ' .. priceBags .. ' tokens por uma scyther bag?', cid)
		npcHandler.topic[cid] = 21
	elseif npcHandler.topic[cid] == 21 and (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) then
		local player = Player(cid)
		if player:removeTokens(priceBags) then
			selfSay('Aqui esta sua bag. Volte sempre!', cid)
			player:addItem("scyther bag", 1)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		else
			selfSay('Voce nao possui todos esses tokens!', cid)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		end
	elseif msgcontains(msg, 'scizor') then
		selfSay('Deseja trocar ' .. priceBags .. ' tokens por uma scizor bag?', cid)
		npcHandler.topic[cid] = 22
	elseif npcHandler.topic[cid] == 22 and (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) then
		local player = Player(cid)
		if player:removeTokens(priceBags) then
			selfSay('Aqui esta sua bag. Volte sempre!', cid)
			player:addItem("scizor bag", 1)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		else
			selfSay('Voce nao possui todos esses tokens!', cid)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		end
	elseif msgcontains(msg, 'sneasel') then
		selfSay('Deseja trocar ' .. priceBags .. ' tokens por uma sneasel bag?', cid)
		npcHandler.topic[cid] = 23
	elseif npcHandler.topic[cid] == 23 and (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) then
		local player = Player(cid)
		if player:removeTokens(priceBags) then
			selfSay('Aqui esta sua bag. Volte sempre!', cid)
			player:addItem("sneasel bag", 1)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		else
			selfSay('Voce nao possui todos esses tokens!', cid)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		end
	elseif msgcontains(msg, 'snorlax') then
		selfSay('Deseja trocar ' .. priceBags .. ' tokens por uma snorlax bag?', cid)
		npcHandler.topic[cid] = 24
	elseif npcHandler.topic[cid] == 24 and (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) then
		local player = Player(cid)
		if player:removeTokens(priceBags) then
			selfSay('Aqui esta sua bag. Volte sempre!', cid)
			player:addItem("snorlax bag", 1)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		else
			selfSay('Voce nao possui todos esses tokens!', cid)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		end
	elseif msgcontains(msg, 'umbreon') then
		selfSay('Deseja trocar ' .. priceBags .. ' tokens por uma umbreon bag?', cid)
		npcHandler.topic[cid] = 25
	elseif npcHandler.topic[cid] == 25 and (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) then
		local player = Player(cid)
		if player:removeTokens(priceBags) then
			selfSay('Aqui esta sua bag. Volte sempre!', cid)
			player:addItem("umbreon bag", 1)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		else
			selfSay('Voce nao possui todos esses tokens!', cid)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		end
	elseif msgcontains(msg, 'vaporeon') then
		selfSay('Deseja trocar ' .. priceBags .. ' tokens por uma vaporeon bag?', cid)
		npcHandler.topic[cid] = 26
	elseif npcHandler.topic[cid] == 26 and (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) then
		local player = Player(cid)
		if player:removeTokens(priceBags) then
			selfSay('Aqui esta sua bag. Volte sempre!', cid)
			player:addItem("vaporeon bag", 1)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		else
			selfSay('Voce nao possui todos esses tokens!', cid)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		end
	elseif msgcontains(msg, 'victrebeel') then
		selfSay('Deseja trocar ' .. priceBags .. ' tokens por uma victrebeel bag?', cid)
		npcHandler.topic[cid] = 27
	elseif npcHandler.topic[cid] == 27 and (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) then
		local player = Player(cid)
		if player:removeTokens(priceBags) then
			selfSay('Aqui esta sua bag. Volte sempre!', cid)
			player:addItem("victrebeel bag", 1)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		else
			selfSay('Voce nao possui todos esses tokens!', cid)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		end
	elseif msgcontains(msg, 'wartortle') then
		selfSay('Deseja trocar ' .. priceBags .. ' tokens por uma wartortle bag?', cid)
		npcHandler.topic[cid] = 28
	elseif npcHandler.topic[cid] == 28 and (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) then
		local player = Player(cid)
		if player:removeTokens(priceBags) then
			selfSay('Aqui esta sua bag. Volte sempre!', cid)
			player:addItem("wartortle bag", 1)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		else
			selfSay('Voce nao possui todos esses tokens!', cid)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

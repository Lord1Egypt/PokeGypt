local storageCathemAll = quests.cathemAll.prizes[1].uid
local storageIndigoLeague = quests.indigoLeague.prizes[1].uid
local storageOakRequest = quests.oakRequest.prizes[1].uid
local storageCeruleanCave = quests.ceruleanCave.prizes[1].uid
local storageCeruleanCave2 = quests.ceruleanCave.prizes[2].uid
local storageCeruleanCave3 = quests.ceruleanCave.prizes[3].uid
local storageThePokemaster = quests.thePokemaster.prizes[1].uid
local storageRedRequest = quests.redRequest.prizes[1].uid
local legendaryIndex = {144, 145, 146, 150, 151, 243, 244, 245, 249, 250, 251, 377, 378, 379, 380, 381, 382, 383, 384, 385, 386}

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end	
	if msgcontains(msg, 'bye') or msgcontains(msg, 'no') or msgcontains(msg, 'nao') then
		selfSay('Tudo bem, volte se mudar de ideia.', cid)
		npcHandler:releaseFocus(cid)
	elseif (msgcontains(msg, 'quest') or msgcontains(msg, 'mission') or msgcontains(msg, 'help') or msgcontains(msg, 'ajuda')  or msgcontains(msg, 'problema')) then
		local player = Player(cid)
		if player:getStorageValue(storageOakRequest) > 0 then
			if player:getLevel() >= quests.thePokemaster.level then
				if not (player:getStorageValue(storageCeruleanCave) == 1 or player:getStorageValue(storageCeruleanCave2) == 1 or player:getStorageValue(storageCeruleanCave3) == 1) then
					selfSay('Voce ainda nao derrotou o temivel pokemon artificial que vem causando problemas na Cerulean Cave. Volte apos derrota-lo!', cid)
					npcHandler:releaseFocus(cid)
				else
					if player:getStorageValue(storageThePokemaster) <= 0 then
						selfSay('Voce conseguiu derrotar o poderoso Mewtwo!!! Estou impressionado com suas habilidades.', cid)
						selfSay('Ha 5 anos atras tive a sorte de encontrar o melhor treinador pokemon, seu nome era Red e era rival de Blue. Em questao de meses ele foi capaz de derrotar a Liga e se tornar o campeao. Mas sua busca por capturar todos os pokemons o fez largar seu cargo de Campeao da Liga.', cid)
						selfSay('Reza a lenda que ele foi capaz ate mesmo de capturar os passaros lendarios e o temivel mewtwo. Apos descobrir da existencia do pokemon que originou Mewtwo, ele partiu em uma jornada para tentar captura-lo e nunca mais voltou.', cid)
						selfSay('A ultima noticia que obtive dele e que ele se encontra em uma montanha no noroeste do oceano. Por favor, encontre-o.', cid)
						player:giveQuestPrize(storageThePokemaster)
						npcHandler:releaseFocus(cid)
					else
						if player:getStorageValue(storageRedRequest) <= 0 then
							selfSay('Por favor, encontre o Red e tente conversar com ele.', cid)
							npcHandler:releaseFocus(cid)
						else
							selfSay('Estou precisando de uma ajuda para {catalogar} Pokemons.', cid)
						end
					end
				end
			else
				selfSay('Voce ainda e muito inexperiente. Volte apos o level ' .. quests.thePokemaster.level .. ".", cid)
				npcHandler:releaseFocus(cid)
			end
		else
			if player:getLevel() >= quests.oakRequest.level then
				if player:getStorageValue(storageIndigoLeague) > 0 then
					selfSay('Muito bem! Vejo que foi capaz de derrotar a Liga. Talvez voce seja capaz me ajudar em uma tarefa. Parece que um poderosissimo Pokemon psiquico criado artificialmente esta causando caos. Me disseram que atualmente ele se encontra na Cerulean cave.', cid)
					player:setStorageValue(storageOakRequest, 1)
					npcHandler:releaseFocus(cid)
				else
					selfSay('Volte apos vencer a Indigo League.', cid)
					npcHandler:releaseFocus(cid)
				end
			else
				selfSay('Voce ainda e muito inexperiente. Volte apos o level ' .. quests.oakRequest.level .. ".", cid)
				npcHandler:releaseFocus(cid)
			end
		end
	elseif msgcontains(msg, 'catch') or msgcontains(msg, 'catalogar') or msgcontains(msg, 'capturar') then
		local player = Player(cid)
		if player:getStorageValue(storageCathemAll) <= 0 then
			selfSay('Gostaria de me ajudar a catalogar todos os pokemons? Para isso preciso que voce capture todos os pokemons nao lendarios.', cid)
			npcHandler.topic[cid] = 1
		elseif player:getStorageValue(storageCathemAll) == 1 then
			local catchRemainTable = {}
			for i = 1, 386 do
				if not isInArray(legendaryIndex, i) then 
					table.insert(catchRemainTable, i)
				end
			end
			local catchRemain = player:getCatchRemain(catchRemainTable)
			if catchRemain == 0 then
				if player:getLevel() >= quests.cathemAll.level then
					selfSay('Parabens, voce conseguiu capturar todos os pokemons. Tome este item antigo, espero que saiba o que fazer com ele.', cid)
					player:giveQuestPrize(storageCathemAll, true)
					player:setStorageValue(storageCathemAll, 2)
					npcHandler:releaseFocus(cid)
				else
					selfSay('Parabens, voce conseguiu capturar todos os pokemons! Volte apos o level ' .. quests.cathemAll.level .. " que te darei um premio.", cid)
					npcHandler:releaseFocus(cid)
				end
			else		
				selfSay('Volte quando tiver capturado todos os pokemons. Ainda faltam ' .. catchRemain .. ".", cid)
				npcHandler:releaseFocus(cid)
			end
		else
			selfSay('Voce ja me ajudou antes. Obrigado!', cid)
			npcHandler:releaseFocus(cid)			
		end
	elseif (msgcontains(msg, 'yes') or msgcontains(msg, 'sim')) and npcHandler.topic[cid] == 1 then
		local player = Player(cid)
		selfSay('Muito obrigado! Volte quando tiver capturado todos eles que entao te darei um premio.', cid)
		player:setStorageValue(storageCathemAll, 1)
		npcHandler:releaseFocus(cid)
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setCallback(CALLBACK_ONTHINK, creatureOnThinkCallback)
npcHandler:setCallback(CALLBACK_ONRELEASEFOCUS, creatureOnReleaseFocusCallback)
npcHandler:addModule(FocusModule:new())

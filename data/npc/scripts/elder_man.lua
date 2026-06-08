local storage = quests.elderManQuest.prizes[1].uid

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
		selfSay('Va, jovem, viva sua vida plenamente!', cid)
		npcHandler:releaseFocus(cid)
	elseif msgcontains(msg, 'mission') or msgcontains(msg, 'quest') then
		selfSay('Veja, nao preciso da sua ajuda para quests, pois em minha vida ja completei todas.', cid)
	elseif msgcontains(msg, 'pokemon') or msgcontains(msg, 'pokemons') then
		selfSay('Durante minha vida eu consegui ver todos os pokemons, inclusive seus mais raros ancestrais.', cid)
	elseif msgcontains(msg, 'ancestral') or msgcontains(msg, 'ancestrais') or msgcontains(msg, 'ancient') or msgcontains(msg, 'elder') then
		selfSay('Sim, muito antigamente existiam os pokemons ancestrais, conhecidos como {ancient}s ou {elder}s. Eles possuiam uma forca extraordinaria. Fico aqui imaginando... quem sabe nao existe uma forma de um pokemon retornar a sua forma ancestral? Ah... se pelo menos eu tivesse uma {pista}...', cid)
	elseif msgcontains(msg, 'pista') or msgcontains(msg, 'pistas') then
		selfSay('Veja, meu jovem, se me trouxer pistas ou informacoes talvez possa descobrir como regredir um pokemon para sua forma ancestral.', cid)
	elseif msgcontains(msg, 'hieroglifo') or msgcontains(msg, 'hieroglyph') then
		local player = Player(cid)
		if player:removeItem("ancient hieroglyph", 1) then
			selfSay('Por Arceus! Como conseguiu este hieroglifo!? Isso nao importa, acho q talvez consiga fazer uma pedra com isso para regredir um pokemon a sua forma ancestral, mas preciso de tempo... Pronto, aqui esta uma {stone} que consegue regredir pokemons, mas talvez uma unica nao seja suficiente', cid)
			player:giveQuestPrize(storage)
			npcHandler:releaseFocus(cid)
		else
			selfSay('Verdade, jovem. Talvez um hieroglifo antigo tenha a resposta pelo que passei boa parte da minha vida procurando. Se conseguir um, por favor, me entregue e te recompensarei com parte do meu conhecimento!', cid)
			npcHandler:releaseFocus(cid)
		end	
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

local priceTokens = 100
local levelMinimum = 100

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
		selfSay('Esta decidido sobre qual destino seguir? Posso te ajudar a tornar-se um {hunter}, {catcher}, {healer}, {blocker} ou {explorer}.', cid)
	elseif msgcontains(msg, 'hunter') then
		selfSay('Tem certeza que deseja tornar-se hunter? O preco desse curso e de ' .. priceTokens .. ' tokens!', cid)
		npcHandler.topic[cid] = 1
	elseif msgcontains(msg, 'catcher') then
		selfSay('Tem certeza que deseja tornar-se catcher? O preco desse curso e de ' .. priceTokens .. ' tokens!', cid)
		npcHandler.topic[cid] = 2
	elseif msgcontains(msg, 'healer') then
		selfSay('Tem certeza que deseja tornar-se healer? O preco desse curso e de ' .. priceTokens .. ' tokens!', cid)
		npcHandler.topic[cid] = 3
	elseif msgcontains(msg, 'blocker') then
		selfSay('Tem certeza que deseja tornar-se blocker? O preco desse curso e de ' .. priceTokens .. ' tokens!', cid)
		npcHandler.topic[cid] = 4
	elseif msgcontains(msg, 'explorer') then
		selfSay('Tem certeza que deseja tornar-se explorer? O preco desse curso e de ' .. priceTokens .. ' tokens!', cid)
		npcHandler.topic[cid] = 5
	elseif (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) and npcHandler.topic[cid] == 1 then
		local player = Player(cid)
		if player:getLevel() >= levelMinimum then		
		if player:removeTokens(priceTokens) then
			selfSay('Parabens! Faca bom proveito de sua nova profissao.', cid)
			player:setVocation("Hunter")
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		else
			selfSay('Voce nao tem como me pagar!', cid)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		end

		else
			selfSay('Desculpe, voce precisa ter ao menos level ' .. levelMinimum .. ".", cid)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		end
	elseif (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) and npcHandler.topic[cid] == 2 then
		local player = Player(cid)
		if player:getLevel() >= levelMinimum then		
			if player:removeTokens(priceTokens) then
				selfSay('Parabens! Faca bom proveito de sua nova profissao.', cid)
				player:setVocation("Catcher")
				npcHandler.topic[cid] = 0
				npcHandler:releaseFocus(cid)
			else
				selfSay('Voce nao tem como me pagar!', cid)
				npcHandler.topic[cid] = 0
				npcHandler:releaseFocus(cid)
			end
		else
			selfSay('Desculpe, voce precisa ter ao menos level ' .. levelMinimum .. ".", cid)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		end
	elseif (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) and npcHandler.topic[cid] == 3 then
		local player = Player(cid)
		if player:getLevel() >= levelMinimum then
			if player:removeTokens(priceTokens) then
				selfSay('Parabens! Faca bom proveito de sua nova profissao.', cid)
				player:setVocation("Healer")
				npcHandler.topic[cid] = 0
				npcHandler:releaseFocus(cid)
			else
				selfSay('Voce nao tem como me pagar!', cid)
				npcHandler.topic[cid] = 0
				npcHandler:releaseFocus(cid)
			end
		else
			selfSay('Desculpe, voce precisa ter ao menos level ' .. levelMinimum .. ".", cid)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		end
	elseif (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) and npcHandler.topic[cid] == 4 then
		local player = Player(cid)
		if player:getLevel() >= levelMinimum then		
			if player:removeTokens(priceTokens) then
				selfSay('Parabens! Faca bom proveito de sua nova profissao.', cid)
				player:setVocation("Blocker")
				npcHandler.topic[cid] = 0
				npcHandler:releaseFocus(cid)
			else
				selfSay('Voce nao tem como me pagar!', cid)
				npcHandler.topic[cid] = 0
				npcHandler:releaseFocus(cid)
			end
		else
			selfSay('Desculpe, voce precisa ter ao menos level ' .. levelMinimum .. ".", cid)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		end
	elseif (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) and npcHandler.topic[cid] == 5 then
		local player = Player(cid)
		if player:getLevel() >= levelMinimum then		
			if player:removeTokens(priceTokens) then
				selfSay('Parabens! Faca bom proveito de sua nova profissao.', cid)
				player:setVocation("Explorer")
				npcHandler.topic[cid] = 0
				npcHandler:releaseFocus(cid)
			else
				selfSay('Voce nao tem como me pagar!', cid)
				npcHandler.topic[cid] = 0
				npcHandler:releaseFocus(cid)
			end
		else
			selfSay('Desculpe, voce precisa ter ao menos level ' .. levelMinimum .. ".", cid)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

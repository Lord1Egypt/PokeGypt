local number = 0

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
		selfSay('Troco {premierball} por tokens.', cid)
	elseif msgcontains(msg, 'premier') or msgcontains(msg, 'premierball') then
		selfSay('Quantos tokens deseja trocar por premierball?', cid)
		npcHandler.topic[cid] = 1
	elseif npcHandler.topic[cid] == 1 then
		number = tonumber(msg)
		if number and number > 0 then
			selfSay('Gostaria de trocar ' .. number .. ' tokens por ' .. number * 5 .. ' premierballs?', cid)
			npcHandler.topic[cid] = 2
		else
			selfSay('Quantos tokens deseja trocar por premierball?', cid)
		end
	elseif npcHandler.topic[cid] == 2 and (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) then
		local player = Player(cid)
		if player:removeTokens(number) then
			selfSay('Aqui esta!', cid)
			player:addItem("empty premierball", number * 5)
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

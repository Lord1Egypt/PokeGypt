local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

-- Travel
local function addTravelKeyword(keyword, cost, destination)
	local travelKeyword = keywordHandler:addKeyword({keyword}, StdModule.say, {npcHandler = npcHandler, text = 'Deseja entrar no ' .. keyword:titleCase() .. ' pagando |TRAVELCOST|?', cost = cost})
	travelKeyword:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = true, cost = cost,  destination = destination})
	travelKeyword:addChildKeyword({'sim'}, StdModule.travel, {npcHandler = npcHandler, premium = true, cost = cost, destination = destination})
	travelKeyword:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, text = 'Talvez uma outra hora.', reset = true})
end

addTravelKeyword('saffari', 100000, Position(1748, 2154, 7))


npcHandler:setMessage(MESSAGE_GREET, "Bem vindo, |PLAYERNAME|. Posso te oferecer uma viagem pelo {saffari}!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate mais. Recomende o saffari para seus amigos.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate logo.")
npcHandler:addModule(FocusModule:new())

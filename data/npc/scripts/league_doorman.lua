local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local timeBetweenQuests = 20*60*60

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = Player(cid)
	if not player then
		return false
	end

	if (msgcontains(msg, "yes") or msgcontains(msg, "sim") or msgcontains(msg, "quest") or msgcontains(msg, "liga")) and npcHandler.topic[cid] == 0 then
		local questStorage = player:getStorageValue(storageLeague)
		if questStorage <= 1 then
			if player:getLevel() < quests.indigoLeague.level then
				npcHandler:say("Voce precisa ser ao menos level " .. quests.indigoLeague.level .. " para participar da liga.", cid)
				npcHandler:releaseFocus(cid)
			else
				npcHandler:say("Tem certeza que esta preparado? Lembre-se que voce so pode desafiar a liga uma vez por dia.", cid)
				npcHandler.topic[cid] = 1
			end
		else
			npcHandler:say("Voce ja venceu a liga!", cid)
			npcHandler:releaseFocus(cid)
		end
	elseif (msgcontains(msg, "yes") or msgcontains(msg, "sim")) and npcHandler.topic[cid] == 1 then
		local timeSinceLast = os.time() - player:getStorageValue(storageLeagueTime)
		local timeRemaining = timeBetweenQuests - timeSinceLast
		if (timeSinceLast > timeBetweenQuests) then
			npcHandler:say("Boa sorte, " .. player:getName() .. "!", cid)
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			player:teleportTo(Position(254, 1071, 7))
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			player:setOnLeague()
			npcHandler:releaseFocus(cid)
		else
			npcHandler:say("Retorne daqui " .. timeRemaining .. " segundos." , cid)
			npcHandler:releaseFocus(cid)
		end
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Ola, |PLAYERNAME|. Posso te levar para a {liga} Pokemon! Lembre-se que voce so pode desafiar a liga uma vez por dia. Deseja tentar?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Ok, volte quando estiver decidido.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

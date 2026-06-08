local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local voices = { {text = 'Eventos sao comigo mesmo!'} }
npcHandler:addModule(VoiceModule:new(voices))

ipsSub = {}

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = Player(cid)
	local playerIp = player:getIp()

	if isInArray(ipsSub, playerIp) then
		npcHandler:say("Eh permitido que apenas 1 IP esteja inscrito em eventos.", cid)
		npcHandler:releaseFocus(cid)
		npcHandler:resetNpc(cid)
		return false
	end
	if msgcontains(msg, "bag") then
		if bagEventIsOpen then
			if player:getLevel() >= 5 then
				if player:getStorageValue(storageBagEvent) < 0 then
					npcHandler:say("Voce foi inscrito com sucesso. Agora basta aguardar que sera transportado automaticamente ao evento.", cid)
					player:setStorageValue(storageBagEvent, 1)
					ipsSub[#ipsSub + 1] = playerIp
					npcHandler:releaseFocus(cid)
					npcHandler:resetNpc(cid)
				else
					npcHandler:say("Voce ja esta inscrito!", cid)
					npcHandler:releaseFocus(cid)
					npcHandler:resetNpc(cid)
				end
			else
				npcHandler:say("Voce precisa ter no minimo level 5 para participar!", cid)
				npcHandler:releaseFocus(cid)
				npcHandler:resetNpc(cid)
			end
		else
			npcHandler:say("Este evento nao esta atualmente aberto!", cid)
			npcHandler:releaseFocus(cid)
			npcHandler:resetNpc(cid)
		end
	elseif msgcontains(msg, "arena") then
		if arenaEventIsOpen then
			if player:getLevel() >= 5 then
				if player:getStorageValue(storageArenaEvent) < 0 then
					npcHandler:say("Voce foi inscrito com sucesso. Agora basta aguardar que sera transportado automaticamente ao evento.", cid)
					player:setStorageValue(storageArenaEvent, 1)
					ipsSub[#ipsSub + 1] = playerIp
					npcHandler:releaseFocus(cid)
					npcHandler:resetNpc(cid)
				else
					npcHandler:say("Voce ja esta inscrito!", cid)
					npcHandler:releaseFocus(cid)
					npcHandler:resetNpc(cid)
				end
			else
				npcHandler:say("Voce precisa ter no minimo level 5 para participar!", cid)
				npcHandler:releaseFocus(cid)
				npcHandler:resetNpc(cid)
			end
		else
			npcHandler:say("Este evento nao esta atualmente aberto!", cid)
			npcHandler:releaseFocus(cid)
			npcHandler:resetNpc(cid)
		end
	elseif msgcontains(msg, "pvp") then
		if arenaPvpEventIsOpen then
			if player:getLevel() >= 5 then
				if player:getStorageValue(storageArenaPvpEvent) < 0 then
					npcHandler:say("Voce foi inscrito com sucesso. Agora basta aguardar que sera transportado automaticamente ao evento.", cid)
					player:setStorageValue(storageArenaPvpEvent, 1)
					ipsSub[#ipsSub + 1] = playerIp
					npcHandler:releaseFocus(cid)
					npcHandler:resetNpc(cid)
				else
					npcHandler:say("Voce ja esta inscrito!", cid)
					npcHandler:releaseFocus(cid)
					npcHandler:resetNpc(cid)
				end
			else
				npcHandler:say("Voce precisa ter no minimo level 5 para participar!", cid)
				npcHandler:releaseFocus(cid)
				npcHandler:resetNpc(cid)
			end
		else
			npcHandler:say("Este evento nao esta atualmente aberto!", cid)
			npcHandler:releaseFocus(cid)
			npcHandler:resetNpc(cid)
		end
	elseif msgcontains(msg, "futebol") then
		if soccerEventIsOpen then
			if player:getLevel() >= 5 then
				if player:getStorageValue(storageSoccerEvent) < 0 then
					npcHandler:say("Voce foi inscrito com sucesso. Agora basta aguardar que sera transportado automaticamente ao evento.", cid)
					player:setStorageValue(storageSoccerEvent, 1)
					ipsSub[#ipsSub + 1] = playerIp
					npcHandler:releaseFocus(cid)
					npcHandler:resetNpc(cid)
				else
					npcHandler:say("Voce ja esta inscrito!", cid)
					npcHandler:releaseFocus(cid)
					npcHandler:resetNpc(cid)
				end
			else
				npcHandler:say("Voce precisa ter no minimo level 5 para participar!", cid)
				npcHandler:releaseFocus(cid)
				npcHandler:resetNpc(cid)
			end
		else
			npcHandler:say("Este evento nao esta atualmente aberto!", cid)
			npcHandler:releaseFocus(cid)
			npcHandler:resetNpc(cid)
		end
	elseif msgcontains(msg, "bye") then
		npcHandler:say("Hm ... tchau.", cid)
		npcHandler:releaseFocus(cid)
		npcHandler:resetNpc(cid)
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

local storages = {quests.boulderBadge.prizes[1].uid, quests.cascadeBadge.prizes[1].uid, quests.thunderBadge.prizes[1].uid, quests.rainbowBadge.prizes[1].uid, quests.soulBadge.prizes[1].uid, quests.marshBadge.prizes[1].uid, quests.volcanoBadge.prizes[1].uid, quests.earthBadge.prizes[1].uid}
local position = Position(537, 1095, 7)

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local timeBetweenQuests = 24*60*60

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end	
	if msgcontains(msg, 'bye') or msgcontains(msg, 'no') or msgcontains(msg, 'nao') then
		selfSay('Volte quando tiver derrotado todos os ginasios de Kanto.', cid)
		npcHandler:releaseFocus(cid)
	elseif msgcontains(msg, 'hi') or msgcontains(msg, 'hello') or msgcontains(msg, 'ola') or msgcontains(msg, 'oi') or msgcontains(msg, 'help') or msgcontains(msg, 'quest') then
		selfSay('Para entrar na Victory Road voce precisa ter derrotado todos os ginasios de Kanto. Gostaria de entrar? Lembre-se que voce tem apenas uma tentativa por dia!', cid)
	elseif msgcontains(msg, 'yes') or msgcontains(msg, 'sim') or msgcontains(msg, 'enter') or msgcontains(msg, 'pass') or msgcontains(msg, 'passar') or msgcontains(msg, 'entrar')  then
		local player = Player(cid)
		if player then
			local timeSinceLast = os.time() - player:getStorageValue(storageVictoryRoadTime)
			local timeRemaining = timeBetweenQuests - timeSinceLast
			if (timeSinceLast > timeBetweenQuests) then
				local canPass = true
				for i = 1, #storages do
					if player:getStorageValue(storages[i]) <= 0 then
						canPass = false
					end
				end
				if canPass then 
					selfSay('Boa sorte!', cid)
					player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					player:teleportTo(position)
					player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					player:setStorageValue(storageVictoryRoadTime, os.time())
					npcHandler:releaseFocus(cid)
				else
					selfSay('Volte quando tiver obtido todas as Insigneas de Kanto.', cid)
					npcHandler:releaseFocus(cid)
				end
			else
				npcHandler:say("Retorne daqui " .. timeRemaining .. " segundos." , cid)
				npcHandler:releaseFocus(cid)
			end
		end
	end
	return true
end


npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setCallback(CALLBACK_ONTHINK, creatureOnThinkCallback)
npcHandler:setCallback(CALLBACK_ONRELEASEFOCUS, creatureOnReleaseFocusCallback)
npcHandler:addModule(FocusModule:new())

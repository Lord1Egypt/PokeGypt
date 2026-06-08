local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local priceBase = 10000  

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local voices = { {text = 'Tenho poderes divinos.'} }
npcHandler:addModule(VoiceModule:new(voices))

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local price = priceBase
	local player = Player(cid)
	local playerLevel = player:getLevel()

	if playerLevel <= 50 then
		price = priceBase 
	elseif playerLevel > 50 and playerLevel < 150 then
		price = math.floor(50 * priceBase * (playerLevel - 50) / 100)
	elseif playerLevel >= 150 then
		price = 50 * priceBase
	end

	if (msgcontains(msg, "yes") or msgcontains(msg, "sim") or msgcontains(msg, "benzer") or msgcontains(msg, "bless")) and npcHandler.topic[cid] == 0 then
		selfSay("Deseja receber uma bencao por " .. price .. "?", cid)
		npcHandler.topic[cid] = 1

	elseif (msgcontains(msg, "yes") or msgcontains(msg, "sim")) and npcHandler.topic[cid] == 1 then
		if player:hasBlessing(7) then
			selfSay("Voce ja esta benzido, boa jornada!", cid)
			npcHandler:releaseFocus(cid)
		else
			if player:removeMoney(price) then
				for i = 1, 7 do
					player:addBlessing(i)
				end
				selfSay("Muito bem, foi abencoado por mim! Continue sua jornada em paz.", cid)
				npcHandler:releaseFocus(cid)
			else
				selfSay("Voce nao possui dinheiro suficiente.", cid)
				npcHandler:releaseFocus(cid)
			end
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

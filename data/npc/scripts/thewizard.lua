local priceOutfits = 25

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
	elseif msgcontains(msg, 'sell') or msgcontains(msg, 'outfits') or msgcontains(msg, 'outfit') or msgcontains(msg, 'buy') or msgcontains(msg, 'comprar') or msgcontains(msg, 'vender') or msgcontains(msg, 'help') then
		local player = Player(cid)
		if player:getSex() == PLAYERSEX_MALE then
			selfSay('Posso te oferecer {Frankenstein}, {Ectoplasm}, {Dracula}, {Skeleton}, {Wizard}, {Death Bringer}, {Plague Doctor} ou {Helloween} em troca de cerebros de zumbis', cid)
		else
			selfSay('Posso te oferecer {Frankenstein}, {Ectoplasm}, {Sucubus}, {Skeleton}, {Witch}, {Death Bringer}, {Plague Doctor} ou {Helloween} em troca de cerebros de zumbis', cid)
		end
	elseif msgcontains(msg, 'Frankenstein') then
		selfSay('Deseja trocar ' .. priceOutfits .. ' half-eaten brain pela outfit Frankenstein?', cid)
		npcHandler.topic[cid] = 1
	elseif npcHandler.topic[cid] == 1 and (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) then
		local player = Player(cid)
		local outfit = 2674
		if player:getSex() == PLAYERSEX_MALE then
			outfit = 2673
		end
		if player:hasOutfit(outfit) then
			selfSay('Voce ja possui essa outfit!', cid)
		else
			if player:removeItem("half-eaten brain", priceOutfits) then
				selfSay('Aqui esta!', cid)
				player:addOutfit(outfit)
			else
				selfSay('Voce nao tem o suficiente!', cid)
			end
		end
	elseif msgcontains(msg, 'Ectoplasm') then
		selfSay('Deseja trocar ' .. priceOutfits .. ' half-eaten brain pela outfit Ectoplasm?', cid)
		npcHandler.topic[cid] = 2
	elseif npcHandler.topic[cid] == 2 and (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) then
		local player = Player(cid)
		local outfit = 2335
		if player:hasOutfit(outfit) then
			selfSay('Voce ja possui essa outfit!', cid)
		else
			if player:removeItem("half-eaten brain", priceOutfits) then
				selfSay('Aqui esta!', cid)
				player:addOutfit(outfit)
			else
				selfSay('Voce nao tem o suficiente!', cid)
			end
		end
	elseif msgcontains(msg, 'Sucubus') or msgcontains(msg, 'Dracula') then
		selfSay('Deseja trocar ' .. priceOutfits .. ' half-eaten brain pela outfit Sucubus/Dracula?', cid)
		npcHandler.topic[cid] = 3
	elseif npcHandler.topic[cid] == 3 and (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) then
		local player = Player(cid)
		local outfit = 2100
		if player:getSex() == PLAYERSEX_MALE then
			outfit = 2103
		end
		if player:hasOutfit(outfit) then
			selfSay('Voce ja possui essa outfit!', cid)
		else
			if player:removeItem("half-eaten brain", priceOutfits) then
				selfSay('Aqui esta!', cid)
				player:addOutfit(outfit)
			else
				selfSay('Voce nao tem o suficiente!', cid)
			end
		end
	elseif msgcontains(msg, 'Skeleton') then
		selfSay('Deseja trocar ' .. priceOutfits .. ' half-eaten brain pela outfit Skeleton?', cid)
		npcHandler.topic[cid] = 4
	elseif npcHandler.topic[cid] == 4 and (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) then
		local player = Player(cid)
		local outfit = 2101
		if player:hasOutfit(outfit) then
			selfSay('Voce ja possui essa outfit!', cid)
		else
			if player:removeItem("half-eaten brain", priceOutfits) then
				selfSay('Aqui esta!', cid)
				player:addOutfit(outfit)
			else
				selfSay('Voce nao tem o suficiente!', cid)
			end
		end
	elseif msgcontains(msg, 'Witch') or msgcontains(msg, 'Wizard') then
		selfSay('Deseja trocar ' .. priceOutfits .. ' half-eaten brain pela outfit Witch/Wizard?', cid)
		npcHandler.topic[cid] = 5
	elseif npcHandler.topic[cid] == 5 and (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) then
		local player = Player(cid)
		local outfit = 2102
		if player:hasOutfit(outfit) then
			selfSay('Voce ja possui essa outfit!', cid)
		else
			if player:removeItem("half-eaten brain", priceOutfits) then
				selfSay('Aqui esta!', cid)
				player:addOutfit(outfit)
			else
				selfSay('Voce nao tem o suficiente!', cid)
			end
		end
	elseif msgcontains(msg, 'Death Bringer') then
		selfSay('Deseja trocar ' .. 2 * priceOutfits .. ' half-eaten brain pela outfit Death Bringer?', cid)
		npcHandler.topic[cid] = 6
	elseif npcHandler.topic[cid] == 6 and (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) then
		local player = Player(cid)
		local outfit = 666
		if player:getSex() == PLAYERSEX_MALE then
			outfit = 667
		end
		if player:hasOutfit(outfit) then
			selfSay('Voce ja possui essa outfit!', cid)
		else
			if player:removeItem("half-eaten brain", 2 * priceOutfits) then
				selfSay('Aqui esta!', cid)
				player:addOutfit(outfit)
				player:addOutfitAddon(outfit, 1)
				player:addOutfitAddon(outfit, 2)
			else
				selfSay('Voce nao tem o suficiente!', cid)
			end
		end
	elseif msgcontains(msg, 'Plague Doctor') then
		selfSay('Deseja trocar ' .. 2 * priceOutfits .. ' half-eaten brain pela outfit Plague Doctor?', cid)
		npcHandler.topic[cid] = 7
	elseif npcHandler.topic[cid] == 7 and (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) then
		local player = Player(cid)
		local outfit = 430
		if player:getSex() == PLAYERSEX_MALE then
			outfit = 431
		end
		if player:hasOutfit(outfit) then
			selfSay('Voce ja possui essa outfit!', cid)
		else
			if player:removeItem("half-eaten brain", 2 * priceOutfits) then
				selfSay('Aqui esta!', cid)
				player:addOutfit(outfit)
				player:addOutfitAddon(outfit, 1)
				player:addOutfitAddon(outfit, 2)
			else
				selfSay('Voce nao tem o suficiente!', cid)
			end
		end
	elseif msgcontains(msg, 'Helloween') then
		selfSay('Deseja trocar ' .. 2 * priceOutfits .. ' half-eaten brain pela outfit Helloween?', cid)
		npcHandler.topic[cid] = 8
	elseif npcHandler.topic[cid] == 8 and (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) then
		local player = Player(cid)
		local outfit = 759
		if player:getSex() == PLAYERSEX_MALE then
			outfit = 760
		end
		if player:hasOutfit(outfit) then
			selfSay('Voce ja possui essa outfit!', cid)
		else
			if player:removeItem("half-eaten brain", 2 * priceOutfits) then
				selfSay('Aqui esta!', cid)
				player:addOutfit(outfit)
				player:addOutfitAddon(outfit, 1)
				player:addOutfitAddon(outfit, 2)
			else
				selfSay('Voce nao tem o suficiente!', cid)
			end
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

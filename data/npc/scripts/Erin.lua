local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local prizes = 
	{
		[1] = {name = "crystal coin", count = 30},
		[2] = {name = "box 3", count = 1},
		[3] = {name = "fire stone", count = 50},
		[4] = {name = "water stone", count = 50},
		[5] = {name = "enigma stone", count = 50},
		[6] = {name = "thunder stone", count = 50},
		[7] = {name = "punch stone", count = 50},
		[8] = {name = "leaf stone", count = 50},
		[9] = {name = "box 4", count = 1}
	}
local prizesNumber = math.random(3, 5)
local idDie = {23582, 5792, 5793, 5794, 5795, 5796, 5797}
local number
local numberTook
local maxTime = 5 * 60 --segundos
local generateBags = true
local idBag = 26760
local minPosBags = {-3, -5}
local maxPosBags = {0, 5}

local function doTeleportPlayerTemple(cid)
	local player = Player(cid)
	if player then
		local templePosition = player:getTown():getTemplePosition()
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		templePosition:sendMagicEffect(CONST_ME_TELEPORT)
		player:teleportTo(templePosition)
	end
	return true
end

local function creatureGreetCallback(cid, message)
	if message == nil then
		return true
	end
	selfSay("Espere sua vez!")
	return false
end

local function creatureOnThinkCallback()
	local npc = Npc()
	local lookDir = npc:getDirection()
	if lookDir ~= 1 then npc:setDirection(1) end
	local npcPosition = npc:getPosition()
	if generateBags then
		for x = npcPosition.x + minPosBags[1], npcPosition.x + maxPosBags[1] do
			for y = npcPosition.y + minPosBags[2], npcPosition.y + maxPosBags[2] do				
				Game.createItem(idBag, 1, Position(x, y, npcPosition.z))
			end
		end
		generateBags = false
	end
	local dicePosition = npc:getPosition()
	local playerPosition = npc:getPosition()
	dicePosition:getNextPosition(npc:getDirection())
	playerPosition:getNextPosition(npc:getDirection())
	playerPosition:getNextPosition(npc:getDirection())
	local diceTile = Tile(dicePosition)
	local dice = diceTile:getTopDownItem()
	local playerTile = Tile(playerPosition)
	local creatures = playerTile:getCreatures()
	if creatures and #creatures > 0 then
		local creature = creatures[1]
		if creature:isPlayer() then
			local cid = creature:getId()
			if not npcHandler:isFocused(cid) then
				if NpcHandler:isInRange(cid) then
					creature:setStorageValue(storageDelayBag, os.time() + maxTime)
					npcHandler:greet(cid)
					npcHandler.topic[cid] = 1
				end
			end

			if npcHandler.topic[cid] == 1 then
				npcHandler.topic[cid] = 2
				selfSay("Proximo player a tentar: " .. creature:getName() .. ". Desejem boa sorte a ele!")
			end

			if npcHandler.topic[cid] == 3 then
				Game.createItem(idDie[1], 1, dicePosition)
				npcHandler.topic[cid] = 4
			end

			if npcHandler.topic[cid] == 4 then
				if dice and dice:getId() ~= idDie[1] then
					if isInArray(idDie, dice:getId()) then
						for key, value in pairs(idDie) do
							if value == dice:getId() then numberTook = key - 1 end
						end					
						selfSay("Player " .. creature:getName() .. " sorteou o numero " .. numberTook .. ".")
						npcHandler.topic[cid] = 5
					end
				end
			end

			if npcHandler.topic[cid] == 5 then			
				if numberTook == number then
					selfSay("Parabens, " .. creature:getName() .. "!" .. " Jogue o dado sobre uma bag para recolher seu premio!")
					npcHandler.topic[cid] = 6
				else
					selfSay("Nao foi dessa vez, " .. creature:getName() .. "!")
					dice:remove()
					doTeleportPlayerTemple(cid)
					local msg = "Player " .. creature:getName() .. " chutou o numero " .. number .. " e sorteou o numero " .. numberTook .. ". Nao foi dessa vez!"
					broadcastMessage(msg, MESSAGE_STATUS_WARNING)
				end
			end

			if npcHandler.topic[cid] == 6 then
				if not dice then
					local found = false
					for x = npcPosition.x + minPosBags[1], npcPosition.x + maxPosBags[1] do
						for y = npcPosition.y + minPosBags[2], npcPosition.y + maxPosBags[2] do
							local throwTile = Tile(Position(x, y, npcPosition.z))
							if throwTile then
								local throwItem = throwTile:getTopDownItem()
								if throwItem and isInArray(idDie, throwItem:getId()) then
									throwItem:remove()
									found = true
								end	
							end
						end
					end
					if found then
						local msg = "Player " .. creature:getName() .. " chutou o numero " .. number .. " e ganhou: " 
						doTeleportPlayerTemple(cid)
						local container = Container(creature:addItem(idBag, 1).uid)
						for i = 1, prizesNumber do
							local random = math.random(1, #prizes)
							container:addItem(prizes[random].name, prizes[random].count)
							if i < prizesNumber then
								msg = msg .. prizes[random].count .. " " .. prizes[random].name .. ", "
							else
								msg = msg .. prizes[random].count .. " " .. prizes[random].name .. ". Parabens!"
							end
						end
						broadcastMessage(msg, MESSAGE_STATUS_WARNING)
					else
						selfSay("Voce jogou o dado no lugar errado, " .. creature:getName() .. "! Recusou seu premio...")
						print("WARNING! Player " .. creature:getName() .. " jogou o dado no lugar errado.")
						for x = playerPosition.x - 7, playerPosition.x + 7 do
							for y = playerPosition.y - 7, playerPosition.y + 7 do
								local throwTile = Tile(Position(x, y, npcPosition.z))
								if throwTile then
									local throwItem = throwTile:getTopDownItem()
									if throwItem and isInArray(idDie, throwItem:getId()) then
										throwItem:remove()
										print("WARNING! Dado perdido deletado.")
									end
								end
							end
						end
						doTeleportPlayerTemple(cid)
					end

				end

			end

			if os.time() > creature:getStorageValue(storageDelayBag) then
				selfSay("Seu tempo se esgotou, " .. creature:getName() .. "!")
				if dice then
					dice:remove()
				end
				doTeleportPlayerTemple(cid)
			end
		else
			creature:remove()
		end
	else
		if dice then
			dice:remove()
		end
	end
	return true
end

local function creatureSayCallback(cid, type, msg)
	local player = Player(cid)
	if npcHandler.topic[cid] == 2 then
		number = tonumber(msg)
		if not number then return true end
		if number > 6 then number = nil end
		if number ~= nil then
			selfSay("Player " .. player:getName() .. " escolheu o numero " .. number .. ". Agora gire o dado!")
			npcHandler.topic[cid] = 3
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setCallback(CALLBACK_GREET, creatureGreetCallback)
npcHandler:setCallback(CALLBACK_ONTHINK, creatureOnThinkCallback)

npcHandler:addModule(FocusModule:new())

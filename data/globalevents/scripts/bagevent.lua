local eventPos = {682, 1204, 6}
local rangeTeleport = 5
local npcPos = {649, 1203, 5}

local function cleanArena()
	local tile = Tile(npcPos[1], npcPos[2], npcPos[3])
	if tile and tile:getCreatureCount() > 0 then
		for i = 1, tile:getCreatureCount() do
			if tile:getCreatures()[i]:isMonster() or tile:getCreatures()[i]:isNpc() and not tile:getCreatures()[i]:isPokemon() then
				tile:getCreatures()[i]:remove()
			end
		end
	end
	return true
end

local function bagEventStop()
	print("WARNING! Encerrando evento bag premiada.")
	cleanArena()
	Game.startRaid("Christmas Saffron")
end

local function bagEventTryStop()
	local playersRemaining = 0
	for x = eventPos[1] - rangeTeleport, eventPos[1] + rangeTeleport do
		for y = eventPos[2] - rangeTeleport, eventPos[2] + rangeTeleport do
			local tile = Tile(x, y, eventPos[3])
			if tile and tile:getCreatureCount() > 0 then
				playersRemaining = playersRemaining + tile:getCreatureCount()
			end
		end
	end
	for x = 651, 673 do
		local tile = Tile(x, 1203, 5)
		if tile and tile:getCreatureCount() > 0 then
			playersRemaining = playersRemaining + tile:getCreatureCount()
		end
	end
	print("WARNING! Players ainda na arena do evento bag premiada: " .. playersRemaining)
	if playersRemaining == 0 then
		bagEventStop()
	else
		addEvent(bagEventTryStop, 2 * 60 * 1000)
	end
end

local function bagEventStart()
	broadcastMessage("Inscricoes para o envento bag premiada encerradas! Players sendo transportados para o evento.", MESSAGE_STATUS_WARNING)
	local players = Game.getPlayers()
	for i = 1, #players do
		local player = players[i]
		if player:getStorageValue(storageBagEvent) > 0 then
			local randomPosx = eventPos[1] + math.random(-rangeTeleport, rangeTeleport)
			local randomPosy = eventPos[2] + math.random(-rangeTeleport, rangeTeleport)
			local teleportPosition = Position(randomPosx, randomPosy, eventPos[3])
			player:teleportTo(teleportPosition)
			player:setStorageValue(storageBagEvent, -1)
		end
	end
	Game.createNpc("Erin", Position(npcPos[1], npcPos[2], npcPos[3]))
	bagEventIsOpen = false
	addEvent(bagEventTryStop, 8 * 60 * 1000)
end

local function fifthBagEventWarning()
	broadcastMessage("Evento bag premiada vai ser iniciado daqui 1 minuto. Para se inscrever, voce deve ter level 5 e deve dizer hi e depois bag ao NPC Manager que se encontra no CP de Saffron. As inscricoes serao encerradas daqui 1 minuto.", MESSAGE_STATUS_WARNING)
	addEvent(bagEventStart, 1 * 60 * 1000)
end

local function fourthBagEventWarning()
	broadcastMessage("Evento bag premiada vai ser iniciado daqui 2 minutos. Para se inscrever, voce deve ter level 5 e deve dizer hi e depois bag ao NPC Manager que se encontra no CP de Saffron.", MESSAGE_STATUS_WARNING)
	addEvent(fifthBagEventWarning, 1 * 60 * 1000)
end

local function thirdBagEventWarning()
	broadcastMessage("Evento bag premiada vai ser iniciado daqui 4 minutos. Para se inscrever, voce deve ter level 5 e deve dizer hi e depois bag ao NPC Manager que se encontra no CP de Saffron.", MESSAGE_STATUS_WARNING)
	addEvent(fourthBagEventWarning, 2 * 60 * 1000)
end

local function secondBagEventWarning()
	broadcastMessage("Evento bag premiada vai ser iniciado daqui 6 minutos. Para se inscrever, voce deve ter level 5 e deve dizer hi e depois bag ao NPC Manager que se encontra no CP de Saffron.", MESSAGE_STATUS_WARNING)
	addEvent(thirdBagEventWarning, 2 * 60 * 1000)
end

local function firstBagEventWarning()
	broadcastMessage("Evento bag premiada vai ser iniciado daqui 8 minutos. Para se inscrever, voce deve ter level 5 e deve dizer hi e depois bag ao NPC Manager que se encontra no CP de Saffron.", MESSAGE_STATUS_WARNING)
	addEvent(secondBagEventWarning, 2 * 60 * 1000)
end

function onTime(interval)
	local day = os.date("%A")
	if day ~= "Sunday" then
		return true
	end
	ipsSub = {}
	broadcastMessage("Evento bag premiada vai ser iniciado daqui 10 minutos. Para se inscrever, voce deve ter level 5 e deve dizer hi e depois bag ao NPC Manager que se encontra no CP de Saffron.", MESSAGE_STATUS_WARNING)
	bagEventIsOpen = true
	addEvent(firstBagEventWarning, 2 * 60 * 1000)
	return true
end

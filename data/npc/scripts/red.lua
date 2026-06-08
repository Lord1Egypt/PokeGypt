local storageRedRequest = quests.redRequest.prizes[1].uid
local storageMewDungeon = quests.mewDungeon.prizes[1].uid

local pokemons = 
{
	[1] = 
		{
			name = "Shiny Pikachu",
			level = 400
		},
	[2] = 
		{
			name = "Shiny Espeon",
			level = 250
		},
	[3] = 
		{
			name = "Shiny Snorlax",
			level = 250
		},
	[4] = 
		{
			name = "Shiny Venusaur",
			level = 250
		},
	[5] = 
		{
			name = "Shiny Blastoise",
			level = 250
		},
	[6] = 
		{
			name = "Elder Charizard",
			level = 250
		},


}

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local function creatureGreetCallback(cid, message)
	if message == nil then
		return true
	end
	if npcHandler:hasFocus() then
		selfSay("Espere sua vez, " .. Player(cid):getName() .. "!")
		return false
	end
	return true
end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end	
	if msgcontains(msg, 'bye') or msgcontains(msg, 'no') or msgcontains(msg, 'nao') then
		selfSay('Va de uma vez, nao tenho tempo a perder com voce!', cid)
		npcHandler:releaseFocus(cid)
	elseif msgcontains(msg, 'mew') or msgcontains(msg, 'lendario') then
		selfSay('Sim! O lendario Mew me derrotou! Mas ficarei mais forte e tentarei captura-lo mais uma vez!', cid)
	elseif msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
		local player = Player(cid)
		if player then
			if player:getLevel() >= quests.redRequest.level then
				if player:getStorageValue(storageRedRequestPre) <= 0 then
					selfSay('Ja que esta me incomodando, quero ver do que voce e capaz!', cid)
					npcHandler.topic[cid] = 1
					npcHandler:setMaxIdleTime(600)
					player:setDuelWithNpc()
				else
					selfSay('Voce ja me venceu, agora nao me atrapalhe mais!', cid)
					npcHandler:releaseFocus(cid)
				end
			else
				selfSay('Nao batalho com noobs. Volte apos o level ' .. quests.redRequest.level .. ".", cid)
				npcHandler:releaseFocus(cid)
			end
		end
	elseif msgcontains(msg, 'quest') or msgcontains(msg, 'mission') or msgcontains(msg, 'prize') or msgcontains(msg, 'recompensa') then
		local player = Player(cid)
		if player then
			if player:getLevel() >= quests.mewDungeon.level then
				if player:getStorageValue(storageRedRequestPre) > 0 then
					if player:getStorageValue(storageRedRequest) <= 0 then
						if player:getStorageValue(storageMewDungeon) <= 0 then
							selfSay('Nao tente me enganar! Sei que tambem nao conseguiu derrotar aquele lendario!', cid)
							npcHandler:releaseFocus(cid)
						else
							selfSay('Impressionante voce ter derrotado o lendario Mew! Tome esta pedra antiga, talvez voce saiba o que fazer com ela!', cid)
							player:giveQuestPrize(storageRedRequest)
							npcHandler:releaseFocus(cid)
						end
					else
						selfSay('O que fez com a pedra que te dei?', cid)
						npcHandler:releaseFocus(cid)
					end
				else
					selfSay('Isso e um insulto?', cid)
				end
			else
				selfSay('Nao converso com noobs. Volte apos o level ' .. quests.mewDungeon.level .. ".", cid)
				npcHandler:releaseFocus(cid)
			end
		end
	end
	return true
end

local function creatureOnReleaseFocusCallback(cid)
	local npc = Npc()
	if hasSummons(npc) then
		local monster = npc:getSummons()[1]
		monster:getPosition():sendMagicEffect(balls.pokeball.effectRelease)
		monster:remove()
	end
	local player = Player(cid)
	if player then
		player:unsetDuelWithNpc()
	end
	return true
end

local function creatureOnDisapearCallback(cid)
	local player = Player(cid)
	if not player then
		npcHandler:updateFocus()
		return true
	end
	if npcHandler:isFocused(cid) then
		if getDistanceTo(cid) >= 0 and getDistanceTo(cid) <= 8 then
			return false
		end
		selfSay("Mais sorte na proxima tentativa, " .. player:getName() .. "!", cid)
		npcHandler:releaseFocus(cid)
	end
	return true
end

local function creatureOnThinkCallback()
	if npcHandler:hasFocus() then
		local npc = Npc()
		local npcPosition = npc:getPosition()
		local spectators = Game.getSpectators(npcPosition, false, true)
		for i = 1, #spectators do
			local player = spectators[i]
			local cid = player:getId()
			if npcHandler:isFocused(cid) and npcHandler.topic[cid] == 1 then
				local duelStatus = player:getDuelWithNpcStatus()
				local monster = npc:getSummons()[1]
				if not monster then
					if pokemons[duelStatus] then
						selfSay(pokemons[duelStatus].name .. ", eu escolho voce!")
						npcPosition:getNextPosition(npc:getDirection())
						monster = Game.createMonster(pokemons[duelStatus].name, npcPosition, false, true, pokemons[duelStatus].level, 0)
						npcPosition:sendMagicEffect(balls.pokeball.effectRelease)
						monster:setMaster(npc)
						local health = monster:getTotalHealth() * 10
						monster:setMaxHealth(health)
						monster:setHealth(health)
						monster:changeSpeed(-monster:getSpeed() + monster:getTotalSpeed())
						player:increaseDuelWithNpcStatus()
					else
						selfSay('Parabens, ' .. player:getName() .. ", foi uma batalha ardua!", cid)
						selfSay('Espere, ' .. player:getName() .. "! Ja que me venceu, talvez voce seja capaz de derrotar aquele unico pokemon que nao fui capaz de capturar! Se o derrotar, me informe e lhe darei um artefato muito antigo", cid)
						player:setStorageValue(storageRedRequestPre, 1)
						npcHandler:releaseFocus(cid)
					end
				end
				if hasSummons(player) and hasSummons(npc) then
					monster:selectTarget(player:getSummons()[1])
				end
				local pokeballs = player:getPokeballs()
				local pokemonsAlive = 0
				for i=1, #pokeballs do
					local ball = pokeballs[i]					
					if ball:getSpecialAttribute("pokeHealth") > 0 then
						pokemonsAlive = pokemonsAlive + 1
					end
				end
				if pokemonsAlive == 0 then
					selfSay("Mais sorte na proxima tentativa, " .. player:getName() .. "!", cid)
					npcHandler:releaseFocus(cid)				
				end
			end
		end

	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setCallback(CALLBACK_ONTHINK, creatureOnThinkCallback)
npcHandler:setCallback(CALLBACK_ONRELEASEFOCUS, creatureOnReleaseFocusCallback)
npcHandler:setCallback(CALLBACK_CREATURE_DISAPPEAR, creatureOnDisapearCallback)
npcHandler:setCallback(CALLBACK_GREET, creatureGreetCallback)
npcHandler:addModule(FocusModule:new())

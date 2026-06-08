local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local timeBetweenQuests = 60*60*5--24*60*60

local easyPokes = {"Bulbasaur","Charmander","Squirtle","Caterpie","Metapod","Weedle","Kakuna","Pidgey","Rattata","Spearow","Ekans","Pikachu","Sandshrew","Nidoran Female","Nidoran Male","Vulpix","Jigglypuff","Zubat","Oddish","Paras","Venonat","Diglett","Meowth","Psyduck","Mankey","Poliwag","Abra","Machop","Bellsprout","Geodude","Magnemite","Doduo","Shellder","Gastly","Krabby","Cubone","Horsea","Goldeen","Magikarp","Ditto","Dratini","Chikorita","Cyndaquil","Totodile","Sentret","Hoothoot","Ledyba","Spinarak","Pichu","Cleffa","Igglybuff","Togepi","Natu","Mareep","Marill","Hoppip","Sunkern","Wooper","Pineco","Snubbull","Slugma","Swinub","Remoraid","Smeargle","Tyrogue","Smoochum","Larvitar","Treecko","Torchic","Mudkip","Poochyena","Zigzagoon","Wurmple","Silcoon","Cascoon","Lotad","Seedot","Taillow","Wingull","Ralts","Kirlia","Surskit","Shroomish","Slakoth","Nincada","Shedinja","Whismur","Makuhita","Azurill","Skitty","Meditite","Electrike","Gulpin","Carvanha","Numel","Trapinch","Swablu","Barboach","Corphish","Baltoy","Feebas","Shuppet","Duskull","Wynaut","Snorunt","Spheal","Bagon","Beldum"}
local mediumPokes = {"Ivysaur","Charmeleon","Wartortle","Butterfree","Beedrill","Pidgeotto","Pidgeot","Raticate","Fearow","Arbok","Raichu","Sandslash","Nidorina","Nidorino","Clefairy","Clefable","Wigglytuff","Golbat","Gloom","Parasect","Venomoth","Dugtrio","Persian","Primeape","Growlithe","Poliwhirl","Kadabra","Machoke","Weepinbell","Tentacool","Graveler","Ponyta","Slowpoke","Magneton","Farfetch'd","Dodrio","Seel","Dewgong","Grimer","Haunter","Onix","Drowzee","Hypno","Kingler","Voltorb","Electrode","Exeggcute","Marowak","Hitmonlee","Hitmonchan","Lickitung","Koffing","Weezing","Rhyhorn","Tangela","Seadra","Seaking","Staryu","Mr._Mime","Jynx","Electabuzz","Eevee","Porygon","Omanyte","Kabuto","Dragonair","Bayleef","Quilava","Croconaw","Furret","Noctowl","Ledian","Ariados","Chinchou","Lanturn","Togetic","Xatu","Flaaffy","Azumarill","Sudowoodo","Skiploom","Jumpluff","Aipom","Sunflora","Yanma","Quagsire","Murkrow","Misdreavus","Unown","Wobbuffet","Girafarig","Forretress","Dunsparce","Gligar","Granbull","Qwilfish","Sneasel","Teddiursa","Magcargo","Piloswine","Corsola","Octillery","Delibird","Mantine","Skarmory","Houndour","Phanpy","Stantler","Hitmontop","Elekid","Magby","Pupitar","Grovyle","Combusken","Marshtomp","Mightyena","Linoone","Beautifly","Dustox","Lombre","Ludicolo","Nuzleaf","Shiftry","Swellow","Pelipper","Masquerain","Breloom","Vigoroth","Ninjask","Loudred","Nosepass","Delcatty","Sableye","Mawile","Aron","Lairon","Manectric","Plusle","Minun","Volbeat","Illumise","Roselia","Swalot","Sharpedo","Wailmer","Camerupt","Torkoal","Spoink","Grumpig","Spinda","Vibrava","Cacnea","Cacturne","Zangoose","Seviper","Lunatone","Solrock","Whiscash","Crawdaunt","Lileep","Anorith","Castform","Kecleon","Banette","Dusclops","Tropius","Chimecho","Absol","Glalie","Sealeo","Clamperl","Huntail","Gorebyss","Luvdisc","Shelgon","Metang"}
local hardPokes = {"Venusaur","Charizard","Blastoise","Nidoqueen","Nidoking","Ninetales","Vileplume","Golduck","Arcanine","Poliwrath","Alakazam","Machamp","Victreebel","Tentacruel","Golem","Rapidash","Slowbro","Muk","Cloyster","Gengar","Exeggutor","Rhydon","Chansey","Kangaskhan","Starmie","Scyther","Magmar","Pinsir","Tauros","Gyarados","Lapras","Vaporeon","Jolteon","Flareon","Omastar","Kabutops","Aerodactyl","Snorlax","Dragonite","Meganium","Typhlosion","Feraligatr","Crobat","Ampharos","Bellossom","Politoed","Espeon","Umbreon","Slowking","Steelix","Scizor","Shuckle","Heracross","Ursaring","Houndoom","Kingdra","Donphan","Porygon2","Miltank","Blissey","Tyranitar","Sceptile","Blaziken","Swampert","Gardevoir","Slaking","Exploud","Hariyama","Aggron","Medicham","Wailord","Flygon","Altaria","Claydol","Cradily","Armaldo","Milotic","Walrein","Relicanth","Salamence","Metagross"}

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local voices = { {text = 'Estou sempre em busca do melhor catcher.'} }
npcHandler:addModule(VoiceModule:new(voices))

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = Player(cid)
	if not player then
		return false
	end

	if msgcontains(msg, "yes") or msgcontains(msg, "sim") or msgcontains(msg, "quest") or msgcontains(msg, "task") or msgcontains(msg, "beat") and npcHandler.topic[cid] == 0 then
		local questStorage = player:getStorageValue(storageCatchQuest)
		if questStorage < 1 then
			if player:getStorageValue(baseStorageCatches + 19) < 2 then
				npcHandler:say("Sua primeira missao e capturar {2 rattatas}. Depois disso retorne aqui que te darei um premio.", cid)
				npcHandler:releaseFocus(cid)
			else
				npcHandler:say("Bom trabalho! Pegue isso como uma recompensa. Tenho outra {quest} para voce.", cid)
				player:addItem(2152, math.random(1, 10))
				player:addItem(26659, 80)
				player:setStorageValue(storageCatchQuest, 1)
			end
		elseif questStorage == 1 then
			if player:getStorageValue(baseStorageCatches + 69) < 2 then
				npcHandler:say("Sua proxima missao e capturar {2 bellsprouts}. Depois disso retorne aqui que te darei um premio.", cid)
				npcHandler:releaseFocus(cid)
			else
				npcHandler:say("Bom trabalho! Pegue isso como uma recompensa. Tenho outra {quest} para voce.", cid)
				player:addItem(2152, math.random(1, 15))
				player:addItem(26688, 30)
				player:addItem(27634, 1)
				player:setStorageValue(storageCatchQuest, 2)
			end
		elseif questStorage > 1 then
			local timeSinceLast = os.time() - player:getStorageValue(storageCatchQuestTime)
			local timeRemaining = timeBetweenQuests - timeSinceLast
			if (timeSinceLast > timeBetweenQuests) then
				npcHandler:say("Posso te passar uma missao {facil}, {media} ou {dificil}, mas lembre-se que missoes dificeis geralmente trazem melhores recompensas. Qual prefere?", cid)
				npcHandler.topic[cid] = 1
			elseif player:getStorageValue(storageCatchQuestDay) == 0 then
				local pokeNumber = player:getStorageValue(storageCatchQuestPoke)
				local pokeName = monstersTable[pokeNumber]
				local number =  player:getStorageValue(storageCatchQuestNumber)
				local startCatch = player:getStorageValue(storageCatchQuestStartCatch)
				local currentCatch = player:getStorageValue(baseStorageCatches + pokeNumber)
				local catches = currentCatch - startCatch
				if catches < number then
					npcHandler:say("Volte depois de capturar {" .. number .." " .. pokeName .. "} ou daqui " .. timeRemaining .. " segundos.", cid)
					npcHandler:releaseFocus(cid)
				else
					local tokens = 1
					if player:getStorageValue(storageCatchQuestDifficulty) == 1 then
						tokens = math.random(2,4)
					elseif player:getStorageValue(storageCatchQuestDifficulty) == 2 then
						tokens = math.random(5,6)
					elseif player:getStorageValue(storageCatchQuestDifficulty) == 3 then
						tokens = math.random(7,8)
					end
					player:addTokens(tokens)
					npcHandler:say("Bom trabalho! Pegue " .. tokens .. " tokens como recompensa. Novo saldo: " .. player:getTokens() .. ".", cid)
					player:setStorageValue(storageCatchQuestDay, -1)
					npcHandler:releaseFocus(cid)
				end
			else
				npcHandler:say("Ja pegou seu premio de hoje. Retorne daqui " .. timeRemaining .. " segundos." , cid)
				npcHandler:releaseFocus(cid)
			end
		end
	elseif (msgcontains(msg, "facil") or msgcontains(msg, "easy") or msgcontains(msg, "media") or msgcontains(msg, "medium") or msgcontains(msg, "dificil") or msgcontains(msg, "hard")) and npcHandler.topic[cid] == 1 then
		player:setStorageValue(storageCatchQuestDay, 0)
		player:setStorageValue(storageCatchQuestTime, os.time())
		local pokeName
		local number = 2
		if msgcontains(msg, "facil") or msgcontains(msg, "easy") then
			number = tostring(math.random(3, 4))
			pokeName = easyPokes[math.random(#easyPokes)]
			player:setStorageValue(storageCatchQuestDifficulty, 1)
		elseif msgcontains(msg, "media") or msgcontains(msg, "medium") then
			number = tostring(math.random(2, 3))
			pokeName = mediumPokes[math.random(#mediumPokes)]
			player:setStorageValue(storageCatchQuestDifficulty, 2)
		elseif msgcontains(msg, "dificil") or msgcontains(msg, "hard") then
			number = tostring(math.random(1, 2))
			pokeName = hardPokes[math.random(#hardPokes)]
			player:setStorageValue(storageCatchQuestDifficulty, 3)
		end
		local monsterType = MonsterType(pokeName)
		if not monsterType then
			print("WARNING! Poke " .. pokeName .. " not found on NPC catcher.")
			npcHandler:say("Encontramos um problema que ja foi reportado para os GMs.", cid)
			npcHandler:releaseFocus(cid)
			return true
		end
		local pokeNumber = monsterType:dexEntry()
		local startCatch = player:getStorageValue(baseStorageCatches + pokeNumber)
		player:setStorageValue(storageCatchQuestNumber, number)
		player:setStorageValue(storageCatchQuestPoke, pokeNumber)
		player:setStorageValue(storageCatchQuestStartCatch, startCatch)
		npcHandler:say("Sei que voce e bom. Vamos ver se hoje voce consegue capturar {" .. number .." " .. pokeName .. "}.", cid)
		npcHandler:releaseFocus(cid)
	else
		if npcHandler.topic[cid] == 0 then
			npcHandler:say("Nao entendi. Gostaria de me {ajudar} com uma {task}?", cid)
			return tue
		elseif npcHandler.topic[cid] == 1 then
			npcHandler:say("Nao entendi. Gostaria de uma task {facil}, {media} ou {dificil}?", cid)
			return tue
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

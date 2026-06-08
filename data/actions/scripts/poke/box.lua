local boxes = 
	{
		box0 = {itemid = 26764, pokes = {"Slowpoke", "Magnemite", "Doduo", "Seel", "Grimer", "Gastly", "Drowzee", "Voltorb", "Cubone", "Koffing", "Cyndaquil", "Pidgeotto", "Weepinbell", "Wooper", "Dratini", "Dunsparce", "Pichu", "Slugma", "Remoraid", "Ledyba", "Goldeen", "Vulpix", "Tentacool", "Bulbasaur", "Charmander", "Squirtle", "Metapod", "Kakuna", "Teddiursa", "Chikorita", "Chinchou", "Cleffa", "Marill", "Natu", "Smoochum", "Phanpy", "Slugma", "Ekans", "Abra", "Mankey", "Psyduck", "Sandshrew", "Kabuto", "Beedrill", "Omanyte", "Butterfree", "Togepi", "Zubat", "Diglett", "Venonat", "Shuckle", "Mareep", "Meowth", "Poliwag", "Growlithe", "Machop", "Ponyta", "Geodude", "Hoothoot", "Pineco", "Sentret", "Swinub", "Totodile"} },
		box1 = {itemid = 26812, pokes = {"Skiploom", "Raticate", "Ariados", "Flaaffy", "Delibird", "Fearow", "Clefairy", "Arbok", "Nidorino", "Nidorina", "Elekid", "Magby", "Ledian", "Dodrio", "Golbat", "Gloom", "Parasect", "Venomoth", "Dugtrio", "Persian", "Poliwhirl", "Machoke", "Quilava", "Yanma", "Graveler", "Slowbro", "Magneton", "Farfetch'd", "Haunter", "Kingler", "Electrode", "Weezing", "Seadra", "Bayleef", "Croconaw", "Qwilfish", "Tyrogue", "Jigglypuff", "Seaking", "Tauros", "Starmie", "Eevee", "Charmeleon", "Wartortle", "Ivysaur", "Pikachu"} },
		box2 = {itemid = 26813, pokes = {"Politoed", "Magcargo", "Noctowl", "Poliwrath", "Nidoking", "Pidgeot", "Sandslash", "Ninetales", "Vileplume", "Primeape", "Nidoqueen", "Granbull", "Jumpluff", "Golduck", "Kadabra", "Rapidash", "Azumarill", "Murkrow", "Clefable", "Wigglytuff", "Dewgong", "Onix", "Cloyster", "Hypno", "Exeggutor", "Marowak", "Hitmonchan", "Quagsire", "Stantler", "Xatu", "Hitmonlee", "Bellossom", "Lanturn", "Pupitar", "Smeargle", "Lickitung", "Golem", "Chansey", "Tangela", "Mr. Mime", "Pinsir", "Espeon", "Umbreon", "Vaporeon", "Jolteon", "Flareon", "Porygon", "Dragonair", "Hitmontop", "Octillery", "Sneasel"} },
		box3 = {itemid = 26814, pokes = {"Dragonite", "Snorlax", "Kabutops", "Omastar", "Kingdra", "Ampharos", "Blissey", "Donphan", "Girafarig", "Mantine", "Miltank", "Porygon2", "Skarmory", "Lapras", "Gyarados", "Magmar", "Electabuzz", "Jynx", "Scyther", "Kangaskhan", "Venusaur", "Crobat", "Heracross", "Meganium", "Piloswine", "Scizor", "Machamp", "Arcanine", "Charizard", "Blastoise", "Tentacruel", "Alakazam", "Feraligatr", "Houndoom", "Gengar", "Rhydon", "Misdreavus", "Wobbuffet", "Raichu", "Slowking", "Steelix", "Sudowoodo", "Typhlosion", "Tyranitar", "Ursaring"} },
		box4 = {itemid = 26815, pokes = {"Shiny Crobat", "Shiny Magikarp", "Shiny Arcanine", "Shiny Alakazam", "Shiny Ninetales", "Shiny Rhydon", "Shiny Pidgeot", "Shiny Raichu", "Shiny Tentacruel", "Shiny Ampharos", "Shiny Feraligatr", "Shiny Gyarados", "Shiny Tangela", "Shiny Ariados", "Shiny Politoed", "Shiny Typhlosion", "Shiny Tauros", "Shiny Butterfree", "Shiny Beedrill", "Shiny Venomoth", "Shiny Espeon", "Shiny Magneton", "Shiny Onix", "Shiny Larvitar", "Shiny Pupitar", "Shiny Machamp", "Shiny Golbat", "Shiny Kingler", "Shiny Dodrio", "Shiny Farfetch'd", "Shiny Parasect", "Shiny Pinsir", "Shiny Zubat", "Shiny Venonat", "Shiny Electrode", "Shiny Muk", "Shiny Stantler", "Shiny Seadra"} },
		box5 = {itemid = 26816, pokes = {"Shiny Crobat", "Shiny Magmar", "Shiny Magikarp", "Shiny Venusaur", "Shiny Charizard", "Shiny Blastoise", "Shiny Arcanine", "Shiny Alakazam", "Shiny Ninetales", "Shiny Gengar", "Shiny Scyther", "Shiny Rhydon", "Shiny Umbreon", "Shiny Pidgeot", "Shiny Raichu", "Shiny Tentacruel", "Shiny Ampharos", "Shiny Feraligatr", "Shiny Meganium", "Shiny Jynx", "Shiny Electabuzz", "Shiny Gyarados", "Shiny Snorlax", "Shiny Tangela", "Shiny Ariados", "Shiny Politoed", "Shiny Typhlosion", "Shiny Tauros", "Shiny Butterfree", "Shiny Beedrill", "Shiny Venomoth", "Shiny Espeon", "Shiny Magneton", "Shiny Onix", "Shiny Larvitar", "Shiny Pupitar", "Shiny Machamp", "Shiny Golbat", "Shiny Kingler", "Shiny Dodrio", "Shiny Farfetch'd", "Shiny Parasect", "Shiny Pinsir", "Shiny Zubat", "Shiny Dratini", "Shiny Venonat", "Shiny Electrode", "Shiny Muk", "Shiny Stantler", "Shiny Marowak", "Shiny Seadra", "Shiny Dragonair", "Shiny Mr. Mime"} },
		box6 = {itemid = 26817, pokes = {""} },
		box7 = {itemid = 26818, pokes = {""} },
		box8 = {itemid = 26819, pokes = {""} }
	}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local itemId = item:getId()
	for key, value in pairs(boxes) do
		if value.itemid == itemId then
			local random = math.random(1, #boxes[key].pokes)
			local pokeName = boxes[key].pokes[random]
			local monsterType = MonsterType(pokeName)
			if not monsterType then
				print("WARNING! Pokemon " .. pokeName .. " not valid for box.")
				return true
			end
			doAddPokeball(player:getId(), pokeName, math.random(monsterType:getMinLevel(), monsterType:getMaxLevel()), 0, getBallKey(balls.ultraball.emptyId), false, 0)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Congratulations! You have found a " .. pokeName .. ".")
			player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
			break
		end
	end
	item:remove(1)
	return true
end

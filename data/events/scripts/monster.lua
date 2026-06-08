local halloweenChance = 4
local christmasChance = 4
local megaChance = 1

local halloweenPokes = 
{
	[1] = 
		{
			name = "Charmander",
			newName = "Mummy Charmander"
		},
	[2] = 
		{
			name = "Pikachu",
			newName = "Ghost Pikachu"
		},
	[3] = 
		{
			name = "Raichu",
			newName = "Pirate Raichu"
		},
	[4] = 
		{
			name = "Fearow",
			newName = "Raven Fearow"
		},
	[5] = 
		{
			name = "Nidoking",
			newName = "Werewolf Nidoking"
		},
	[6] = 
		{
			name = "Vileplume",
			newName = "Frankstein Vileplume"
		},
	[7] = 
		{
			name = "Golem",
			newName = "Skull Golem"
		},
	[8] = 
		{
			name = "Haunter",
			newName = "Hauting Haunter"
		},
	[9] = 
		{
			name = "Hypno",
			newName = "Panic Hypno"
		},
	[10] = 
		{
			name = "Cubone",
			newName = "Pumpkin Cubone"
		},
	[11] = 
		{
			name = "Marowak",
			newName = "Executioner Marowak"
		},
	[12] = 
		{
			name = "Vaporeon",
			newName = "Witch Vaporeon"
		},
	[13] = 
		{
			name = "Jolteon",
			newName = "Vampire Jolteon"
		},
	[14] = 
		{
			name = "Flareon",
			newName = "Cultist Flareon"
		},
	[15] = 
		{
			name = "Omanyte",
			newName = "Undead Omanyte"
		},
	[16] = 
		{
			name = "Omastar",
			newName = "Undead Omastar"
		},
	[17] = 
		{
			name = "Kabuto",
			newName = "Undead Kabuto"
		},
	[18] = 
		{
			name = "Kabutops",
			newName = "Undead Kabutops"
		},
	[19] = 
		{
			name = "Aerodactyl",
			newName = "Undead Aerodactyl"
		},
	[20] = 
		{
			name = "Scizor",
			newName = "Devil Scizor"
		},
}

local christmasPokes = 
{
	[1] = 
		{
			name = "Snorlax",
			newName = "Santa Snorlax"
		},
	[2] = 
		{
			name = "Diglett",
			newName = "Xmas Diglett"
		},
	[3] = 
		{
			name = "Caterpie",
			newName = "Xmas Caterpie"
		},
	[4] = 
		{
			name = "Psyduck",
			newName = "Xmas Psyduck"
		},
	[5] = 
		{
			name = "Seel",
			newName = "Xmas Seel"
		},
	[6] = 
		{
			name = "Pikachu",
			newName = "Xmas Pikachu"
		},
	[7] = 
		{
			name = "Jynx",
			newName = "Xmas Jynx"
		},
	[8] = 
		{
			name = "Bulbasaur",
			newName = "Xmas Bulbasaur"
		},
	[9] = 
		{
			name = "Ditto",
			newName = "Xmas Ditto"
		},
	[10] = 
		{
			name = "Elekid",
			newName = "Xmas Elekid"
		},
	[11] = 
		{
			name = "Eevee",
			newName = "Xmas Eevee"
		},
	[12] = 
		{
			name = "Charmander",
			newName = "Xmas Charmander"
		},
	[13] = 
		{
			name = "Squirtle",
			newName = "Xmas Squirtle"
		},
	[14] = 
		{
			name = "Rattata",
			newName = "Xmas Rattata"
		},
	[15] = 
		{
			name = "Golbat",
			newName = "Xmas Golbat"
		},
	[16] = 
		{
			name = "Aipom",
			newName = "Xmas Aipom"
		},
	[17] = 
		{
			name = "Ledyba",
			newName = "Xmas Ledyba"
		},
	[18] = 
		{
			name = "Totodile",
			newName = "Xmas Totodile"
		},
	[19] = 
		{
			name = "Abra",
			newName = "Xmas Abra"
		},
	[20] = 
		{
			name = "Chikorita",
			newName = "Xmas Chikorita"
		},
	[21] = 
		{
			name = "Meowth",
			newName = "Xmas Meowth"
		},
	[22] = 
		{
			name = "Gastly",
			newName = "Xmas Gastly"
		},
	[23] = 
		{
			name = "Jigglypuff",
			newName = "Xmas Jigglypuff"
		},
	[24] = 
		{
			name = "Clefairy",
			newName = "Xmas Clefairy"
		},
	[25] = 
		{
			name = "Wooper",
			newName = "Xmas Wooper"
		},
	[26] = 
		{
			name = "Togepi",
			newName = "Xmas Togepi"
		},
	[27] = 
		{
			name = "Teddiursa",
			newName = "Xmas Teddiursa"
		},
	[28] = 
		{
			name = "Machop",
			newName = "Xmas Machop"
		},
	[29] = 
		{
			name = "Cubone",
			newName = "Xmas Cubone"
		},
	[30] = 
		{
			name = "Hitmontop",
			newName = "Xmas Hitmontop"
		},
	[31] = 
		{
			name = "Mantine",
			newName = "Xmas Mantine"
		},
	[32] = 
		{
			name = "Blissey",
			newName = "Santa Blissey"
		},
	[33] = 
		{
			name = "Miltank",
			newName = "Reindeer Miltank"
		},
	[34] = 
		{
			name = "Armaldo",
			newName = "Grinch Armaldo"
		},
	[35] = 
		{
			name = "Aggron",
			newName = "Snowman Aggron"
		},
	[36] = 
		{
			name = "Sudowoodo",
			newName = "Decorated Sudowoodo"
		},
	[37] = 
		{
			name = "Banette",
			newName = "Grinch Banette"
		},
}

function Monster:onSpawn(position, startup, artificial)
	if not artificial then
		local name = self:getName()
		local monsterType = MonsterType(name)
		if math.random(1, 100) <= shinyChance then
			if monsterType:hasShiny() > 0 then
				local shinyName = "Shiny " .. name
				local shinyMonsterType = MonsterType(shinyName)
				if not shinyMonsterType then
					print("WARNING! " .. shinyName .. " not found for respawn.")
				else
					Game.createMonster(shinyName, position, false, false, 0, 0)
					return false
				end
			end
		end
--		if math.random(1, 100) <= halloweenChance then --halloween
--			for i = 1, #halloweenPokes do
--				if name == halloweenPokes[i].name then
--					Game.createMonster(halloweenPokes[i].newName, position, false, false, 0, 0)
--					return false
--				end
--			end
--		end
		if math.random(1, 100) <= christmasChance then --christmas
			for i = 1, #christmasPokes do
				if name == christmasPokes[i].name then
					Game.createMonster(christmasPokes[i].newName, position, false, false, 0, 0)
					return false
				end
			end
		end
--		if math.random(1, 100) <= megaChance then --random mega
--			if monsterType:hasMega() > 0 then
--				local megaName = "Mega " .. name
--				local megaMonsterType = MonsterType(megaName)
--				if not megaMonsterType then
--					print("WARNING! " .. megaName .. " not found for respawn.")
--				else
--					Game.createMonster(megaName, position, false, false, 0, 0)
--					return false
--				end
--			end
--		end
	end
	return true
end

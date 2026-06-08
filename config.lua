monsterLevelDamage = 0.02 -- 2% bonus damage per level
monsterLevelExp = 0.10 -- 10% bonus exp per level
monsterLevelSpeed = 0.03 -- 3% bonus speed per level
monsterLevelHealth = 0.05 -- 5% bonus health per level
monsterLevelLoot = 0.01 -- 1% bonus loot per level
monsterPrefix = "" -- Ghoul [Lv 100]

-- Combat settings
-- NOTE: valid values for worldType are: "pvp", "no-pvp" and "pvp-enforced"
worldType = "no-pvp"
hotkeyAimbotEnabled = true
protectionLevel = 1
killsToRedSkull = 3
killsToBlackSkull = 6
pzLocked = 60000
removeChargesFromRunes = true
timeToDecreaseFrags = 24 * 60 * 60 * 1000
whiteSkullTime = 15 * 60 * 1000
stairJumpExhaustion = 2000
experienceByKillingPlayers = false
expFromPlayersLevelRange = 75

-- Connection Config
-- NOTE: maxPlayers set to 0 means no limit
ip = "127.0.0.1"
bindOnlyGlobalAddress = false
loginProtocolPort = 7171
gameProtocolPort = 7172
statusProtocolPort = 7171
maxPlayers = 0
motd = "Welcome to PokeGypt!"
onePlayerOnlinePerAccount = true
allowClones = false
serverName = "PokeGypt"
statusTimeout = 5000
replaceKickOnLogin = true
maxPacketsPerSecond = 80 -- default 25

-- Deaths
-- NOTE: Leave deathLosePercent as -1 if you want to use the default
-- death penalty formula. For the old formula, set it to 10. For
-- no skill/experience loss, set it to 0.
deathLosePercent = -1

-- Houses
-- NOTE: set housePriceEachSQM to -1 to disable the ingame buy house functionality
housePriceEachSQM = 1000
houseRentPeriod = "daily"

-- Item Usage
timeBetweenActions = 200
timeBetweenExActions = 500

-- Map
-- NOTE: set mapName WITHOUT .otbm at the end
mapName = "global_dash"
mapAuthor = "Komic"

-- Market
marketOfferDuration = 30 * 24 * 60 * 60
premiumToCreateMarketOffer = false
checkExpiredMarketOffersEachMinutes = 60
maxMarketOffersAtATimePerPlayer = 100

-- SQLite (default database engine for PokeGypt -- no MySQL server needed)
-- The database file is created automatically on first launch from schema_sqlite.sql
sqliteDatabase = "pokegypt.sqlite"

-- MySQL (kept for reference / optional AAC website use -- not used by the SQLite build)
mysqlHost = "127.0.0.1"
mysqlUser = "root"
mysqlPass = ""
mysqlDatabase = "pokegypt"
mysqlPort = 3306
mysqlSock = ""
passwordType = "sha1"

-- Misc.
allowChangeOutfit = true
freePremium = false
kickIdlePlayerAfterMinutes = 15
maxMessageBuffer = 4
emoteSpells = false
classicEquipmentSlots = false

-- Rates
-- NOTE: rateExp is not used if you have enabled stages in data/XML/stages.xml
rateExp = 2
rateSkill = 3
rateLoot = 2
rateMagic = 3
rateSpawn = 1

-- Monsters
deSpawnRange = 2
deSpawnRadius = 50

-- Stamina
staminaSystem = false

-- Scripts
warnUnsafeScripts = true
convertUnsafeScripts = true

-- Startup
-- NOTE: defaultPriority only works on Windows and sets process
-- priority, valid values are: "normal", "above-normal", "high"
defaultPriority = "high"
startupDatabaseOptimization = false

-- Status server information
ownerName = "Lord1Egypt"
ownerEmail = ""
url = "https://github.com/Lord1Egypt/PokeGypt"
location = "Egypt"

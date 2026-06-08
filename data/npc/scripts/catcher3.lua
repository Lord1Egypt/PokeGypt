local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

function Player.getPokeballs(self)
	local ret = {}

	if not hasSummons(self) then
		local ballOn = self:getSlotItem(CONST_SLOT_AMMO)
		if ballOn and ballOn:isPokeball() then
			table.insert(ret, ballOn)
		end
	end

	local backpack = self:getSlotItem(CONST_SLOT_BACKPACK)
	if ItemType(backpack:getId()):isContainer() then
		local size = backpack:getSize()
		for i = 0, size-1 do
			local item = backpack:getItem(i)
			if item:isPokeball() then
				table.insert(ret, item)
			end
		end
	end
	return ret
end

function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	if msgcontains(msg, 'no') then
		selfSay('Ok then.', cid)
	elseif msgcontains(msg, 'yes') or msgcontains(msg, 'quest') or msgcontains(msg, 'beat') then
		










		local player = Player(cid)
		local playerHealth = player:getHealth()
		local playerMaxHealth = player:getMaxHealth()

		if playerHealth < playerMaxHealth then
			player:addHealth(playerMaxHealth - playerHealth)
		end
		
		if hasSummons(player) then
			doRemoveSummon(cid)
		end

		local balls = player:getPokeballs()
		for i=1, #balls do
			local ball = balls[i]
			ball:setSpecialAttribute("pokeHealth", 100000)
		end
		selfSay('Here you are young adept, take care yourself.', cid)
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	end

	npcHandler:releaseFocus(cid)
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

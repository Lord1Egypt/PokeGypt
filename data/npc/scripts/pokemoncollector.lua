local priceLinearSlope = 12
local priceLinearIntercept = 1900
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
	
	msg = firstToUpper(msg)

	if msgcontains(msg, 'bye') then
		selfSay('Ok then.', cid)
		npcHandler:releaseFocus(cid)
	elseif msgcontains(msg, 'name') or msgcontains(msg, 'sell') or msgcontains(msg, 'buy') then
		selfSay('Just say the name of the pokemon you wanna sell me.', cid)
	elseif msg == "Pikachu" then
		selfSay('I do not like this pokemon.', cid)
	else
		local player = Player(cid)
		local monsterType = MonsterType(msg)

		if monsterType then
			local balls = player:getPokeballs()
			for i=1, #balls do
				local ball = balls[i]
				local name = firstToUpper(ball:getSpecialAttribute("pokeName"))
				if name == msg then
					local isBallBeingUsed = ball:getSpecialAttribute("isBeingUsed")
					if isBallBeingUsed and isBallBeingUsed == 1 then
						selfSay('Sorry, not possible while using the Pokemon.', cid)
						return true
					end

					local boost = ball:getSpecialAttribute("pokeBoost") or 0
					local level = ball:getSpecialAttribute("pokeLevel")
					local rawPrice = math.abs(( monsterType:getHealth()/10 + monsterType:getBaseSpeed()/2 + monsterType:getMeleeDamage(self) + monsterType:getDefense() +
monsterType:getMoveMagicAttackBase() + monsterType:getMoveMagicDefenseBase())* priceLinearSlope - priceLinearIntercept)
					if rawPrice < 500 then
          					rawPrice = 500
					end
					local price = rawPrice + boost * 1000
					if msgcontains(msg, 'Shiny')  then
						price = 5 * math.floor(rawPrice/1.5) + boost * 1000
					end
					if ball:remove() then
						selfSay('Take ' .. price .. ' by your ' .. name .. ' level ' .. level .. ' boost ' .. boost .. '. Thanks!', cid)
						player:addMoney(price)
						player:refreshPokemonBar({}, {})
					end
					return true
				end
			end
			selfSay('You do not have this pokemon.', cid)
		else
			selfSay('I do not like this pokemon.', cid)
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

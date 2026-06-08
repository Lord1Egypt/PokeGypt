function Creature:onChangeOutfit(outfit)
	if self:isPlayer() then
		if self:isOnEvent() then
			return false
		end
	end
	return true
end

function Creature:onAreaCombat(tile, isAggressive)
	return true
end

function Creature:onTargetCombat(target)
	if self ~= nil then
		if self:isPlayer() and target:isMonster() then
			if isSummon(target) and target:getMaster():isNpc() and not self:isDuelingWithNpc() then
				return RETURNVALUE_YOUMAYNOTATTACKTHISCREATURE
			end
			if isSummon(target) and target:getMaster() == self then
				return RETURNVALUE_YOUMAYNOTATTACKTHISCREATURE
			end
		elseif self:isPlayer() and target:isPlayer() then
			if hasSummons(target) then
				return RETURNVALUE_YOUMAYNOTATTACKTHISCREATURE
			end
		elseif self:isMonster() and target:isPlayer() then
			if isSummon(self) and self:getMaster():isNpc() then
				return RETURNVALUE_YOUMAYNOTATTACKTHISCREATURE
			end
			if hasSummons(target) then
--				self:removeTarget(target)
--				self:searchTarget()
--				if self ~= target:getSummons()[1] then					
--					self:selectTarget(Creature(target:getSummons()[1]))
--				end
				return RETURNVALUE_YOUMAYNOTATTACKTHISCREATURE
			end
		elseif self:isMonster() and target:isMonster() then
			if isSummon(self) and isSummon(target) and target:getMaster():isNpc() and self:getMaster():isPlayer() and not self:getMaster():isDuelingWithNpc() then
				return RETURNVALUE_YOUMAYNOTATTACKTHISCREATURE
			end
			if isSummon(self) and isSummon(target) and self:getMaster():isNpc() and target:getMaster():isPlayer() and not target:getMaster():isDuelingWithNpc() then
				return RETURNVALUE_YOUMAYNOTATTACKTHISCREATURE
			end
--		else --tile damage
		end
	end
	return true	
end



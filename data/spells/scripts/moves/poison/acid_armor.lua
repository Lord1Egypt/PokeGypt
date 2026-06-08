function onCastSpell(creature, variant)
	local target = creature:getTarget()
	if not target then return true end

	return true
end

function onStepIn(creature, item, position, fromPosition)

	local teleport = Teleport(item.uid)
	if not teleport then return false end
	local destination = teleport:getDestination()
	local tileDestination = Tile(destination)
	if not tileDestination then return false end
	local itemsDestination = tileDestination:getItems()

	for i = 1, #itemsDestination do
		local itemDestination = itemsDestination[i]
		local teleportDestination = Teleport(itemDestination.uid)
		if teleportDestination then
			print("WARNING! Teleport on position " .. destination.x .. "," .. destination.y .. "," .. destination.z .. " sending to another teleport.")
			creature:teleportTo(creature:getTown():getTemplePosition())
			return false
		end
	end

	if item:getId() == 1387 then
		if item.actionid > 30020 and item.actionid < 30050 then
			local player = creature:getPlayer()
			if player == nil then
				return false
			end

			local town = Town(item.actionid - 30020)
			player:setTown(town)
		end
	end

	return true
end

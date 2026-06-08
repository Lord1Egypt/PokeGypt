function onMove(creature, toPosition, fromPosition)
	local player = Player(creature:getId())
    if player:isOnFly() then
--	if toPosition.x > 2080 or toPosition.x < 209 or toPosition.y > 2342 or toPosition.y < 611 then
--		player:teleportTo(fromPosition, false)
--		fromPosition:sendMagicEffect(CONST_ME_POFF)
--		return false
--	end

        local fromTile = Tile(fromPosition)
        local fromItem = fromTile:getItemById(flyFloor)
        if fromItem then
            fromItem:remove()
        end
--	local toTile = Tile(toPosition)
--	if toTile then
--		local ground = toTile:getGround()
--		if ground then
--			player:unregisterEvent("FlyEvent")
--			print("unregister onmove")
--			return true
--		end
--	end
        toPosition:createFlyFloor()
    end
    return true
end

local prerequisites = 
{
	[1] = { aid = 110, preStorage = quests.oakRequest.prizes[1].uid },
	[2] = { aid = 111, preStorage = quests.thePokemaster.prizes[1].uid },
	[3] = { aid = 112, preStorage = storageRedRequestPre }
}

function onStepIn(creature, item, position, fromPosition)
	if not creature:isPlayer() then
		return false
	end

	local aid = item:getActionId()

	if aid then
		for i = 1, #prerequisites do
			if aid == prerequisites[i].aid then
				local preStorage = creature:getStorageValue(prerequisites[i].preStorage)
				if preStorage <= 0 then
					creature:sendTextMessage(MESSAGE_INFO_DESCR, "Uma forca mistica te puxa para tras.")
					creature:teleportTo(fromPosition, true)
					return false
				end
				break
			end
		end
	end

	return true
end

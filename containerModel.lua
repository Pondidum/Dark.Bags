local addon, ns = ...

local containerModel = {
	
	new = function()

		local this = {}

		local bags = {}			--index = bagID, value == bag

		events.register("ITEM_LOCK_CHANGED", function(self, bagID, slotID)

			bags[bagID].lockChanged(slotID)
			
		end)

		return this 

	end,

}

ns.containerModel = containerModel
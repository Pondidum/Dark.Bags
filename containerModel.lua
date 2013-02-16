local addon, ns = ...
local events = Dark.core.events

local containerModel = {
	
	new = function(rangeStart, rangeEnd)

		local this = {
			bags = {}
		}

		this.update = function()

			local bags = {}

			for bagID = rangeStart, rangeEnd do 
				bags[bagID] = ns.bagModel.new(bagID)
			end

			this.bags = bags

		end

		events.register("ITEM_LOCK_CHANGED", nil, function(self, event, bagID, slotID)

			print("onItemLockChanged")
			this.bags[bagID].lockChanged(slotID)
			
		end)

		events.register("BAG_UPDATE_COOLDOWN", nil, function(self, event)

			print("onBagUpdateCooldown")
			for bagID, model in pairs(this.bags) do 
				model.updateCooldown()
			end

		end)

		events.register("BAG_UPDATE_DELAYED", nil, function(self, event)

			print("onBagUpdateDelayed")
			this.update()

		end)

		return this 

	end,

}

ns.containerModel = containerModel
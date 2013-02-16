local addon, ns = ...

local bagModel = {
	
	new = function(bagID)

		local this = {
			name = "",
			link = "",
			slots = 0,
			free = 0,
			contents = {},
		}

		this.update = function()

			local bagName = GetBagName(bagID)
			local name, link = GetItemInfo(bagName)
			local free, bagType = GetContainerNumFreeSlots(bagID)
			local total =  GetContainerNumSlots(bagID)

			local contents = {}

			for slotID = 1, GetContainerNumSlots(bagID) do
				contents[slotID] = ns.itemModel.new(bagID, slotID)
			end

			this.name = name
			this.link = link
			this.slots = total
			this.free = free
			this.contents = contents

		end

		this.lockChanged = function(slotID)

			if this.contents[slotID] then
				this.contents[slotID].lockChanged()
			end
			
		end

		this.updateCooldown = function()

			for slot, model in pairs(this.contents) do 
				model.updateCooldown()
			end

		end

		this.update()

		return this 
	end,

}

ns.bagModel = bagModel
local addon, ns = ...

local bagModel = {
	
	new = function()

		local this = {}
		local slots = {}

		this.lockChanged = function(slotID)

			if slots[slotID] then
				slots[slotID].lockChanged()
			end
			
		end

		return this 
	end,

}

ns.bagModel = bagModel
local addon, ns = ...
local slotComponent = ns.slotComponent

local slotBuilder = {

	new = function(self)

		self.bagFrames = {}
		self.slots = {}

		self.start = REAGENTBANK_CONTAINER --  -3
		self.finish = NUM_BAG_SLOTS + NUM_BANKBAGSLOTS

	end,

	getOrCreate = function(self, bagID)

		local bag = self.bagFrames[bagID]

		if bag then
			return bag
		end

		bag = CreateFrame("Frame", "DarkBagsBag"..bagID, UIParent)
		bagFrame:Hide()
		bagFrame:SetID(bagID)

		self.bagFrames[bagID] = bagFrame

	end,

	populate = function(self)

		for bagID = self.start, self.finish do

			local bagFrame = self:getOrCreate(bagID)
			local slots = GetContainerNumSlots(bagID)

			for slotID = 1, slots do

				local component = slotComponent:new(bagID, slotID)
				component:setParent(bagFrame)

				table.insert(self.slots, component)

			end

		end

	end,
}

ns.slotBuilder = slotBuilder

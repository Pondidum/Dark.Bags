local addon, ns = ...
local class = ns.lib.class

local slotComponent = ns.slotComponent

local contentsModel = class:extend({

	ctor = function(self)

		self.bagFrames = {}
		self.slots = {}

		self.start = REAGENTBANK_CONTAINER --  -3
		self.finish = NUM_BAG_SLOTS + NUM_BANKBAGSLOTS

	end,

	getOrCreate = function(self, bagID)

		local frame = self.bagFrames[bagID]

		if frame then
			return frame
		end

		frame = CreateFrame("Frame", "DarkBagsBag"..bagID, UIParent)
		frame:SetID(bagID)

		self.bagFrames[bagID] = frame

		return frame
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
})

ns.contentsModel = contentsModel

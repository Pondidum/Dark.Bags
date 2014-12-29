local addon, ns = ...

local class = ns.lib.class
local events = ns.lib.events

local orchestrator = class:extend({

	ctor = function(self, slotBuilder)
		self:include(events)

		self:register("BAG_UPDATE_COOLDOWN")
		self:register("BAG_UPDATE_DELAYED")

		self.builder = slotBuilder
	end,

	BAG_UPDATE_DELAYED = function(self)
		self:updateSlots()
	end,

	BAG_UPDATE_COOLDOWN = function(self)
		self:updateSlots()
	end,

	updateSlots = function(self)

		for i, slot in ipairs(self.builder.slots) do
			slot:updateModel()
			slot:updateView()
		end

	end,
})
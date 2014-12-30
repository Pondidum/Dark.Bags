local addon, ns = ...

local class = ns.lib.class
local events = ns.lib.events

local modelUpdater = class:extend({

	ctor = function(self, contentsModel)
		self:include(events)

		self:register("BAG_UPDATE_COOLDOWN")
		self:register("BAG_UPDATE_DELAYED")

		self.model = contentsModel
	end,

	BAG_UPDATE_DELAYED = function(self)
		self:updateSlots()
	end,

	BAG_UPDATE_COOLDOWN = function(self)
		self:updateSlots()
	end,

	updateSlots = function(self)

		self.model.forEach(function(i, slot)
			slot:updateModel()
			slot:updateView()
		end)

	end,
})

ns.modelUpdater = modelUpdater
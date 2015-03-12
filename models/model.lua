local addon, ns = ...

local class = ns.lib.class
local events = ns.lib.events

local itemModel = ns.itemModel

local model = class:extend({

	events = {
		"BAG_UPDATE_DELAYED",
		"BANKFRAME_OPENED",
		"BAG_UPDATE_COOLDOWN",
		"ITEM_LOCK_CHANGED",
	},

	ctor = function(self, containerIDs)
		self:include(events)

		self.containerIDs = containerIDs
		self.storage = {}
	end,

	BAG_UPDATE_DELAYED = function(self)
		self:fullRescan()
	end,

	BANKFRAME_OPENED = function(self)
		self:fullRescan()
	end,

	BAG_UPDATE_COOLDOWN = function(self)
		self:updateCooldowns()
	end,

	ITEM_LOCK_CHANGED = function(self)
		self:updateCooldowns()
	end,

	getContents = function(self)

		local current = 0

		return function()

			current = current + 1

			local containerID = self.containerIDs[current]

			if not containerID or not self.storage[containerID] then
				return nil
			end

			return containerID, self.storage[containerID] --i trust me to not modify the table by refrence...
		end

	end,

	quickScan = function(self)

		for bagID, slots in pairs(self.storage) do
			for slotID, contents in pairs(slots) do
				contents:update()
			end
		end

	end,

	fullRescan = function(self)

		for i, bag in ipairs(self.containerIDs) do

			self.storage[bag] = self.storage[bag] or {}

			for slot = 1, GetContainerNumSlots(bag) do

				local info = self.storage[bag][slot] or itemModel:new(bag, slot)

				info:update()

				self.storage[bag][slot] = info

			end

		end

		self:onContentsChanged()

	end,

	updateCooldowns = function(self)
		self:quickScan()
		self:onCooldownsUpdated()
	end,



	onContentsChanged = function(self)
	end,

	onCooldownsUpdated = function(self)
	end,
})

ns.model = model

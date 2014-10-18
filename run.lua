local addon, ns = ...

local core = Dark.core
local views = ns.views

local containerSet = {

	extend = function(self, this)
		return setmetatable(this, { __index = self})
	end,

	new = function(self)

		local this = setmetatable({}, { __index = self })
		this:ctor()
		return this
	end,

	ctor = function(self)

		local cache = core.cache.new(function(i)
			return views.item.new(self.name .. "BagItem"..i)
		end)

		local model = ns.model.new(self.containers)
		local view = views.bagContainer.new(self.name, UIParent, cache)

		self:customise(view.frame)

		model.onContentsChanged = function()
			cache.recycleAll()
			view.populate(model.getContents())
		end

		model.onCooldownsUpdated = function()
			view.update()
		end

		self.frame = view.frame

	end,

	range = function(self, start, finish)

		local out = {}

		for i = start, finish do
			table.insert(out, i)
		end

		return unpack(out)

	end
}


local bankSet = containerSet:extend({

	name = "DarkBagsBank",
	containers = {
		REAGENTBANK_CONTAINER,
		BANK_CONTAINER,
		containerSet:range(NUM_BAG_SLOTS + 1, NUM_BAG_SLOTS + NUM_BANKBAGSLOTS)
	},

	customise = function(self, frame)
		frame:Hide()
		frame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 10, -40)
		frame:SetSize(450, 200)
	end,

})

local bagSet = containerSet:extend({

	name = "DarkBagsBackpack",
	containers = {
		containerSet:range(BACKPACK_CONTAINER, NUM_BAG_SLOTS)
	},

	customise = function(self, frame)
		frame:SetPoint("TOPRIGHT", MultiBarRight, "BOTTOMRIGHT", 0, -10)
		frame:SetSize(450, 200)
	end,
})

local run = function()

	local pack = bagSet:new()
	local bank = bankSet:new()

	local ui = ns.controllers.uiIntegration.new(pack.frame, bank.frame)
	ui.hook()

	local gold = ns.goldDisplay.new()
	local bankBar = ns.bankBar

end

run()
Dark.bags = ns
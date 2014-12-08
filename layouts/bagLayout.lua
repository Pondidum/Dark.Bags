local addon, ns = ...

local layoutEngine = Darker.layoutEngine
local layout = ns.layout

local bagLayout = layout:extend({

	ctor = function(self)

		self.container = CreateFrame("Frame", "DarkBagsContainerLayout", UIParent)
		self.engine = layoutEngine:new(self.container, {
			type = "vertical",
			origin = "TOPLEFT",
			wrap = false,
			itemSpacing = 6,
			autosize = "both"
		})

		self.bags = {}
	end,

	performLayout = function(self, contents)

		for i, slotComponent in contents do

			local bag = self:getOrCreateBag(slotComponent.bag)
			bag:add(slotComponent)

		end

		self.engine:performLayout()
	end,

	getOrCreateBag = function(self, bagID)

		local bag = self.bags[bagID]

		if bag then
			return bag
		end

		bag = slotContainer:new()

		bags[bagID] = bag
		self.engine:addChild(bag)

		return bag
	end,


})

ns.layout:add("bagLayout", bagLayout)

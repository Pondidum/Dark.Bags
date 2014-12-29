local addon, ns = ...

local layoutEngine = ns.lib.engine
local layout = ns.layout
local slotContainer = ns.slotContainer

local bagLayout = layout:extend({

	ctor = function(self)

		self.container = CreateFrame("Frame", "DarkBagsContainerLayout", UIParent)

		self.engine = layoutEngine:new(self.container, {
			layout = "vertical",
			origin = "TOPLEFT",
			wrap = false,
			itemSpacing = 6,
			autosize = "both"
		})

		self.bags = {}
	end,

	performLayout = function(self, contents)

		for i, slotComponent in ipairs(contents) do

			local bag = self:getOrCreateBag(slotComponent.bag)
			bag:add(slotComponent)

		end

		for id, bag in pairs(self.bags) do
			bag.engine:performLayout()
		end

		self.engine:performLayout()
	end,

	getOrCreateBag = function(self, bagID)

		local bag = self.bags[bagID]

		if bag then
			return bag
		end

		bag = slotContainer:new(bagID)

		self.bags[bagID] = bag
		self.engine:addChild(bag.frame)

		return bag
	end,


})

ns.layout:add("bagLayout", bagLayout)
ns.bagLayout = bagLayout

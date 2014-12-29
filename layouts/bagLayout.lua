local addon, ns = ...

local layoutEngine = ns.lib.engine
local layout = ns.layout
local slotContainer = ns.slotContainer

local bagLayout = layout:extend({

	ctor = function(self, bagStart, bagFinish)

		self.bagStart = bagStart or BACKPACK_CONTAINER
		self.bagFinish = bagFinish or BACKPACK_CONTAINER + NUM_BAG_SLOTS

		self.container = CreateFrame("Frame", "DarkBagsContainerLayout", UIParent)

		self.engine = layoutEngine:new(self.container, {
			layout = "vertical",
			origin = "TOPLEFT",
			wrap = false,
			itemSpacing = 6,
			autosize = "both"
		})

		self.bags = {}

		tinsert(UISpecialFrames, self.container:GetName())

		local toggle = ns.bagToggle:new(self)
		toggle:hook()

	end,

	performLayout = function(self, contents)

		for i, slotComponent in ipairs(contents) do

			if slotComponent.bag >= self.bagStart and slotComponent.bag <= self.bagFinish then
				local bag = self:getOrCreateBag(slotComponent.bag)
				bag:add(slotComponent)
			end

		end

		self:forEachBag(function(bag) bag.engine:performLayout() end)
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

	forEachBag = function(self, action)

		for id, bag in pairs(self.bags) do
			action(bag)
		end

	end,

	show = function(self)

		self.container:Show()
		self:forEachBag(function(bag) bag:show() end)

	end,

	hide = function(self)

		self.container:Hide()
		self:forEachBag(function(bag) bag:hide() end)

	end,

	toggle = function(self)

		if self.container:IsShown() then
			self:hide()
		else
			self:show()
		end

	end,
})

ns.layout:add("bagLayout", bagLayout)
ns.bagLayout = bagLayout

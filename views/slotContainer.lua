local addon, ns = ...

local class = ns.lib.class
local style = ns.lib.style
local layoutEngine = ns.lib.engine

local slotContainer = class:extend({

	ctor = function(self, nameSuffix)

		self.frame = CreateFrame("Frame", "DarkBagsContainer" .. nameSuffix, UIParent)
		self.frame:SetWidth(306)

		self.engine = layoutEngine:new(self.frame, {
			layout = "horizontal",
			origin = "TOPLEFT",
			wrap = true,
			itemSpacing = 6,
			autosize = "y"
		})

		style:frame(self.frame)
		self.items = {}
	end,

	add = function(self, component)
		self.engine:addChild(component.frame)
		table.insert(self.items, component.frame)
	end,

	show = function(self)

		self.frame:Show()

		for i, item in ipairs(self.items) do
			item:Show()
		end

	end,

	hide = function(self)

		self.frame:Hide()

		for i, item in ipairs(self.items) do
			item:Hide()
		end

	end,

})

ns.slotContainer = slotContainer

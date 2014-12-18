local addon, ns = ...

local class = ns.lib.class
local layoutEngine = ns.lib.engine

local slotContainer = class:extend({

	ctor = function(self, nameSuffix)

		self.frame = CreateFrame("Frame", "DarkBagsContainer" .. nameSuffix, UIParent)
		self.frame:SetWidth(250)

		self.engine = layoutEngine:new(self.frame, {
			type = "horizontal",
			origin = "TOPLEFT",
			wrap = true,
			itemSpacing = 6,
			autosize = "y"
		})

	end,

	add = function(self, component)
		self.engine:addChild(component.frame)
	end,

})

ns.slotContainer = slotContainer

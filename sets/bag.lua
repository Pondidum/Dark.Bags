local addon, ns = ...

local container = ns.sets.container

ns.sets.bag = container:extend({

	name = "DarkBagsBackpack",
	containers = {
		container:range(BACKPACK_CONTAINER, NUM_BAG_SLOTS)
	},

	customise = function(self, frame)
		frame:SetPoint("TOPRIGHT", MultiBarRight, "BOTTOMRIGHT", 0, -10)
		frame:SetSize(450, 200)
	end,
})

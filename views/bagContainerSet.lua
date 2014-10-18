local addon, ns = ...

local containerSet = ns.containerSet

local bagContainerSet = containerSet:extend({

	name = "DarkBagsBackpack",
	containers = {
		containerSet:range(BACKPACK_CONTAINER, NUM_BAG_SLOTS)
	},

	customise = function(self, frame)
		frame:SetPoint("TOPRIGHT", MultiBarRight, "BOTTOMRIGHT", 0, -10)
		frame:SetSize(450, 200)
	end,
})

ns.bagContainerSet = bagContainerSet


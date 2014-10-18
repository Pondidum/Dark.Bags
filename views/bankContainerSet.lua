local addon, ns = ...

local containerSet = ns.containerSet

local bankContainerSet = containerSet:extend({

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

ns.bankContainerSet = bankContainerSet

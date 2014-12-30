local addon, ns = ...

local sets = ns.sets

local run = function()

	--disable blizzard
	OpenAllBags = function() end
	OpenBackpack = function() end
	CloseAllBags = function() end
	CloseBackpack = function() end
	ToggleBackpack = function() end
	ToggleAllBags = function() end

	local model = ns.contentsModel:new()
	local updater = ns.modelUpdater:new(model)
	updater:updateSlots()

	local layout = ns.bagLayout:new(BACKPACK_CONTAINER, BACKPACK_CONTAINER + NUM_BAG_SLOTS)
	layout:performLayout(model.slots)
	layout:hide()

	layout.container:SetPoint("LEFT", UIParent, "LEFT", 20, 0)

end

run()
Dark.bags = ns
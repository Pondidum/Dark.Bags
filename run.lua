local addon, ns = ...

local core = Dark.core
local views = ns.views

local createBagItem = function(i)
	return views.item.new("DarkBagItem"..i)
end

local run = function()

	local model = ns.model.new()

	local cache = core.cache.new(createBagItem)
	ns.bagItemCache = cache

	local rootContainer = CreateFrame("Frame", "DarkBags", UIParent)

	rootContainer:SetPoint("TOPRIGHT", MultiBarRight, "BOTTOMRIGHT", 0, -10)
	rootContainer:SetSize(394, 400)

	local view = views.bagContainer.new("DarkBagsBackpack", rootContainer, model, BACKPACK_CONTAINER, NUM_BAG_SLOTS)
	view.frame:SetPoint("RIGHT")
	view.frame:SetPoint("TOP")

	model.onContentsChanged = function()
		cache.recycleAll()
		view.populate()
	end

	model.onCooldownsUpdated = function()
		view.update()
	end

	local ui = ns.controllers.uiIntegration.new(rootContainer)
	 ui.hook()

end

run()
Dark.bags = ns
local addon, ns = ...

local core = Dark.core
local views = ns.views

local createBagItem = function(i)
	return views.item.new("DarkBagItem"..i)
end

local backpack = function()

end

local run = function()



	local cache = core.cache.new(createBagItem)
	ns.bagItemCache = cache

	local model = ns.model.new(BACKPACK_CONTAINER, NUM_BAG_SLOTS)

	local view = views.bagContainer.new("DarkBagsBackpack", UIParent, model, BACKPACK_CONTAINER, NUM_BAG_SLOTS)
	view.frame:SetPoint("TOPRIGHT", MultiBarRight, "BOTTOMRIGHT", 0, -10)
	view.frame:SetSize(450, 200)

	model.onContentsChanged = function()
		cache.recycleAll()
		view.populate()
	end

	model.onCooldownsUpdated = function()
		view.update()
	end

	local ui = ns.controllers.uiIntegration.new(view.frame)
	ui.hook()

	local gold = ns.goldDisplay.new()
end

run()
Dark.bags = ns
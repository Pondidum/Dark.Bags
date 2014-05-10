local addon, ns = ...

local core = Dark.core
local views = ns.views

local createBagItem = function(i)
	return views.item.new("DarkBagItem"..i)
end

local buildBackpack = function()

	local model = ns.model.new(BACKPACK_CONTAINER, NUM_BAG_SLOTS)

	local view = views.bagContainer.new("DarkBagsBackpack", UIParent)

	view.frame:SetPoint("TOPRIGHT", MultiBarRight, "BOTTOMRIGHT", 0, -10)
	view.frame:SetSize(450, 200)

	model.onContentsChanged = function()
		ns.bagItemCache.recycleAll()
		view.populate(model.getContents())
	end

	model.onCooldownsUpdated = function()
		view.update()
	end

	return view.frame

end

local run = function()

	local cache = core.cache.new(createBagItem)
	ns.bagItemCache = cache

	local pack = buildBackpack()

	local ui = ns.controllers.uiIntegration.new(pack)
	ui.hook()

	local gold = ns.goldDisplay.new()
end

run()
Dark.bags = ns
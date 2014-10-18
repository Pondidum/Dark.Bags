local addon, ns = ...

local core = Dark.core
local views = ns.views

local range = function(start, finish)

	local out = {}

	for i=start, finish do
		table.insert(out, i)
	end

	return out

end

local buildBackpack = function()

	local cache = core.cache.new(function(i)
		return views.item.new("DarkBagsBagItem"..i)
	end)

	local model = ns.model.new(range(BACKPACK_CONTAINER, NUM_BAG_SLOTS))
	local view = views.bagContainer.new("DarkBagsBackpack", UIParent, cache)

	view.frame:SetPoint("TOPRIGHT", MultiBarRight, "BOTTOMRIGHT", 0, -10)
	view.frame:SetSize(450, 200)

	model.onContentsChanged = function()
		cache.recycleAll()
		view.populate(model.getContents())
	end

	model.onCooldownsUpdated = function()
		view.update()
	end

	return view.frame

end

local buildBank = function()

	local cache = core.cache.new(function(i)
		return views.item.new("DarkBagsBankItem"..i)
	end)

	local ids = range(NUM_BAG_SLOTS + 1, NUM_BAG_SLOTS + NUM_BANKBAGSLOTS)
	table.insert(ids, 1, BANK_CONTAINER)

	local model = ns.model.new(ids)
	local view = views.bagContainer.new("DarkBagsBank", UIParent, cache)

	view.frame:Hide()
	view.frame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 10, -40)
	view.frame:SetSize(450, 200)

	model.onContentsChanged = function()
		cache.recycleAll()
		view.populate(model.getContents())
	end

	model.onCooldownsUpdated = function()
		view.update()
	end

	return view.frame
end

local run = function()

	local pack = buildBackpack()
	local bank = buildBank()

	local ui = ns.controllers.uiIntegration.new(pack, bank)
	ui.hook()

	local gold = ns.goldDisplay.new()
	local bankBar = ns.bankBar

end

run()
Dark.bags = ns
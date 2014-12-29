local addon, ns = ...

local sets = ns.sets

local run = function()

	local builder = ns.slotBuilder:new()
	builder:populate()

	for i, slot in ipairs(builder.slots) do
		slot:updateModel()
		slot:updateView()
	end

	local layout = ns.bagLayout:new(BACKPACK_CONTAINER, BACKPACK_CONTAINER + NUM_BAG_SLOTS)
	layout:performLayout(builder.slots)

	layout.container:SetPoint("LEFT", UIParent, "LEFT", 20, 0)
end

run()
Dark.bags = ns
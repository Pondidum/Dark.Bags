local addon, ns = ...

local sets = ns.sets

local run = function()


	local builder = ns.slotBuilder:new()
	builder:populate()

	local layout = ns.bagLayout:new()
	layout:performLayout(builder.slots)

	layout.container:SetPoint("LEFT", 20)
end

run()
Dark.bags = ns
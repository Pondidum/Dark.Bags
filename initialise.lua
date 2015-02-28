local addon, ns = ...

local initialise = function()

	ns.groups = {}
	ns.sets = {}

	ns.views = {}
	ns.controllers = {}

	local dark = Darker

	ns.lib = {
		class = dark.class,
		events = dark.events,
		style = dark.style,
	}

end

initialise()

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
		cache = dark.mixins.cache,
		style = dark.style,
		colors = dark.media.colors,
		fonts = dark.media.fonts,
	}

end

initialise()

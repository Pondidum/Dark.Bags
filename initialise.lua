local addon, ns = ...

local initialise = function()

	ns.lib = {
		class = Darker.class,
		style = Darker.style,
		events = Darker.events,
		engine = Darker.layoutEngine,
	}

end

initialise()
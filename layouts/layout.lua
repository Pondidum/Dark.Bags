local addon, ns = ...

local layouts = {}

local layout = class:extend({

	ctor = function(self)
	end,

	activate = function(self)

	end,

	add = function(self, name, implementation)
		layouts[name] = implementation
	end,
})

ns.layout = layout

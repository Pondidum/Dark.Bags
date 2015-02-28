local addon, ns = ...

local core = Dark.core
local layout = core.layout

local group = {

	new = function(self, name, parent, options)

		local frame = CreateFrame("Frame", name, parent)
		layout.init(frame, options)

		local this = setmetatable({}, { __index = self })

		this.frame = frame

		return this

	end,

	clear = function(self)

		self.frame.clear()

	end,

	add = function(self, subGroup)

		local frame = self.frame

		frame.add(subGroup.frame or subGroup)

	end,

}

ns.group = group

local addon, ns = ...

local core = Dark.core
local config = ns.config

local bar = core.frameSeries:extend({

	new = function(self)

		local this = setmetatable({}, { __index = self })

		this.frames = {}
		this.frameSize = config.buttonSize
		this.spacing = config.spacing

		this:init()

		return this
	end,

	afterLayout = function(self)

		local anchor, other, otherAnchor, x, y = unpack(self.anchor)

		self.container:ClearAllPoints()
		self.container:SetPoint(anchor, other , otherAnchor, x, y)

	end,

	updateAll = function(self)

		for i, frame in ipairs(self.frames) do
			self:updateButton(frame)
		end

	end,

	updateButton = function(self, frame)
	end,

})

ns.controllers.bar = bar

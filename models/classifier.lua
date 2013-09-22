local addon, ns = ...

local core = Dark.core

local classifier = {
	
	new = function() 

		local this = setmetatable({}, { __index = self })

		this.events = core.events.new()
		
		return this

	end,

	addRescanEvent = function(self, event)
		self.events.register(event, self:requestRescan)
	end,

	requestRescan = function(self)
	
	end,

	beforeClassify = function(self)
	end

	classify = function(self, details)
	end,

	afterClassify = function(self)
	end,

}

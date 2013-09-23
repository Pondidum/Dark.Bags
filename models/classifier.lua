local addon, ns = ...

local core = Dark.core

local classifiers = {}
local requestRescan

ns.classifiers = {
    
	new = function(self) 

		local this = {}

		this.events = core.events.new()
		
		this.addRescanEvent = function(self, event)
			self.events.register(event, requestRescan)
		end

		this.requestRescan = requestRescan

		this.beforeClassify = function() end
		this.classify = function(details) end
		this.afterClassify = function() end

		self.add(this)

		return this

	end,

	add = function(classifier)

		table.insert(classifiers, classifier)

	end,

	beforeClassify = function()

		for i, c in ipairs(classifiers) do
			c:beforeClassify()
		end

	end,

	classify = function(detail)
	
		for i, c in ipairs(classifier) do
			c:classify(detail)
		end

	end,

	afterClassify = function()

		for i, c in ipairs(classifiers) do
			c:afterClassify()
		end

	end,

	onRescanRequested = function(action)
		requestRescan = action
	end,

}

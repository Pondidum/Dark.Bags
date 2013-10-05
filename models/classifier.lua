local addon, ns = ...

local core = Dark.core

local classifiers = {}
local requestRescan

ns.classifiers = {
    
	new = function(buildAction) 

		local this = {}
		local events = core.events.new()
		
		this.addRescanEvent = function(event)
			events.register(event, requestRescan)
		end

		this.requestRescan = requestRescan

		this.beforeClassify = function() end
		this.classify = function(details) end
		this.afterClassify = function() end

		table.insert(classifiers, classifier)

		buildAction(this)

	end,

	beforeClassify = function()

		for i, c in ipairs(classifiers) do
			c:beforeClassify()
		end

	end,

	classify = function(detail)
	
		for i, c in ipairs(classifiers) do
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

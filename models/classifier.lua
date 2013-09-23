local addon, ns = ...

local core = Dark.core

local classifiers = {}

ns.classifiers = {
    
	new = function(self) 

		local this = {}

		this.events = core.events.new()
		
		this.addRescanEvent = function(self, event)
			self.events.register(event, self:requestRescan)
		end

		this.requestRescan = function(self) end
		this.beforeClassify = function(self) end
		this.classify = function(self, details) end
		this.afterClassify = function(self) end

		self:add(this)

		return this

	end,

	add = function(self, classifier)

		table.insert(classifiers, classifier)

	end,

	beforeClassify = function(self)

		for i, c in ipairs(classifiers) do
			c:beforeClassify()
		end

	end,

	classify = function(self, detail)
	
		for i, c in ipairs(classifier) do
			c:classify(detail)
		end

	end,

	afterClassify = function(self)

		for i, c in ipairs(classifiers) do
			c:afterClassify()
		end

	end
}

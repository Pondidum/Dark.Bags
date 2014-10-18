local addon, ns = ...

local core = Dark.core
local views = ns.views
local groups = ns.groups

local containerSet = {

	extend = function(self, this)
		return setmetatable(this, { __index = self})
	end,

	new = function(self)

		local this = setmetatable({}, { __index = self })
		this:ctor()
		return this
	end,

	ctor = function(self)

		local cache = core.cache.new(function(i)
			return views.item.new(self.name .. "BagItem"..i)
		end)

		local model = ns.model.new(self.containers)
		local view = groups.bagContainer.new(self.name, UIParent, cache)

		self:customise(view.frame)

		model.onContentsChanged = function()
			cache.recycleAll()
			view.populate(model.getContents())
		end

		model.onCooldownsUpdated = function()
			view.update()
		end

		self.frame = view.frame

	end,

	range = function(self, start, finish)

		local out = {}

		for i = start, finish do
			table.insert(out, i)
		end

		return unpack(out)

	end
}

ns.sets.container = containerSet

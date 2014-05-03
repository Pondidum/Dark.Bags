local addon, ns = ...

local itemModel = {

	new = function(self, bag, slot)

		local this = setmetatable({}, { __index = self })
		this.bag = bag
		this.slot = slot

		return this
	end,

	update = function(self)

		local texture, count, locked, quality, readable, lootable, link = GetContainerItemInfo(self.bag, self.slot)

		self.texture = texture
		self.count = count
		self.locked = locked
		self.quality = quality
		self.readable = readable
		self.lootable = lootable
		self.link = link

	end,

	classify = function(self, classifiers)

		self.tags = self.tags or {}
		classifiers.classify(self)
	end,

}


ns.itemModel = itemModel

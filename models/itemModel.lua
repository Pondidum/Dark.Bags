local addon, ns = ...

local core = Dark.core

local itemModel = {

	new = function(self, bag, slot)

		local this = setmetatable({}, { __index = self })
		this.bag = bag
		this.slot = slot

		return this
	end,

	update = function(self)

		local texture, count, locked, quality, readable, lootable, link = GetContainerItemInfo(self.bag, self.slot)
		local start, duration, enable = GetContainerItemCooldown(self.bag, self.slot)

		--GetContainerItemInfo does not return a quality value for all items.  If it does not, it returns -1
		if link and quality < LE_ITEM_QUALITY_COMMON then
			quality = select(3, GetItemInfo(link))
		end

		local r, g, b = GetItemQualityColor(quality or 1)

		self.texture = texture
		self.count = count
		self.locked = locked
		self.quality = quality
		self.qualityColor = { r, g, b, core.colors.shadow[4] }
		self.readable = readable
		self.lootable = lootable
		self.link = link

		self.cooldownStart = start
		self.cooldownDuration = duration
		self.cooldownFinish = start + duration

	end,

	classify = function(self, classifiers)

		self.tags = self.tags or {}
		classifiers.classify(self)
	end,

}


ns.itemModel = itemModel

local addon, ns = ...

local itemModel = {
	
	new = function(bagID, slotID)

		local this = {}

		local texture, count, locked, quality, readable, lootable, link = GetContainerItemInfo(bagID, slotID)

		this.texture = texture
		this.count = count
		this.locked = locked
		this.quality = quality
		this.readable = readable
		this.lootable = lootable
		this.link = link

		local isInSet, setNames = GetContainerItemEquipmentSetInfo(bagID, slotID)

		this.equipmentSets = setNames
		this.containerTypes = GetItemFamily(link)


		this.lockChanged = function()

			local xTexture, xCount, isLocked = GetContainerItemInfo(bagID, slotID)

			this.locked = isLocked
			
		end

		return this
	end,

}

ns.itemModel = itemModel
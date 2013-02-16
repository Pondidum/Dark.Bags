local addon, ns = ...

local itemModel = {
	
	new = function(bagID, slotID)

		local this = {
			name	 = "",
			texture	 = "",
			link	 = "",
			count	 = 0,
			locked	 = nil,
			quality	 = 0,
			readable = nil,
			lootable = nil,
			cooldownStart = 0,
			cooldownDuration = 0,
		}

		this.update = function()

			local texture, count, locked, badQuality, readable, lootable, link = GetContainerItemInfo(bagID, slotID)		
			local name, itemLink, itemQuality 

			if link then
				name, itemLink, itemQuality = GetItemInfo(link)
			end

			local start, duration = GetContainerItemCooldown(bagID, slotID)

			this.name = name
			this.texture = texture
			this.link = link
			this.count = count
			this.locked = locked
			this.quality = itemQuality
			this.readable = readable
			this.lootable = lootable

			this.cooldownStart = start
			this.cooldownDuration = duration

		end

		this.updateCooldown = function()

			local start, duration = GetContainerItemCooldown(bagID, slotID)

			this.cooldownStart = start
			this.cooldownDuration = duration

		end

		this.lockChanged = function()

			local xTexture, xCount, isLocked = GetContainerItemInfo(bagID, slotID)
			this.locked = isLocked
			
		end

		this.print = function()

			local r, g, b, color = GetItemQualityColor(this.quality)

			print(string.format("|c%s%s|r x%d", 
								color,
								this.name,
								this.count))
		end

		this.update()

		return this

	end,

}

ns.itemModel = itemModel
local addon, ns = ...
local class = Darker.class
local style = Darker.style

local slotComponent = class:extend({

	ctor = function(self, bag, slot)

		self.bag = bag
		self.slot = slot
		self.model = {}

		self:createFrame()
		self:updateModel()

	end,

	createFrame = function(self)

		local name = string.format("DarkBagsSlotViewB%sS%s", self.bag, self.slot)

		local frame = CreateFrame("Button", name, UIParent, "ContainerFrameItemButtonTemplate")
		local count = frame.Count
		local icon = frame.icon
		local cooldown = _G[frame:GetName() .."Cooldown"]

		frame:SetID(self.slot)
		frame:SetPushedTexture("")
		frame:SetNormalTexture("")

		frame:SetSize(25, 25)
		style:border(frame)

		frame.BattlepayItemTexture:SetTexture(nil)
		frame.BattlepayItemTexture:Hide()
		frame:Show()

		count:ClearAllPoints()
		count:SetPoint("BottomRight")
		count:Show()

		icon:ClearAllPoints()
		icon:SetAllPoints(frame)
		icon:SetTexCoord(.08, .92, .08, .92)

		self.frame = frame
		self.count = count
		self.icon = icon
		self.cooldown = cooldown

	end,

	updateModel = function(self)

		local texture, count, locked, quality, readable, lootable, link = GetContainerItemInfo(self.bag, self.slot)
		local start, duration, enable = GetContainerItemCooldown(self.bag, self.slot)

		--GetContainerItemInfo does not return a quality value for all items.
		-- If it does not, it returns -1
		if link and quality < LE_ITEM_QUALITY_COMMON then
			quality = select(3, GetItemInfo(link))
		end

		local r, g, b = GetItemQualityColor(quality or 1)

		local model = self.model

		model.texture = texture
		model.count = count
		model.locked = locked
		model.quality = quality
		model.qualityColor = { r, g, b, 0.8 }
		model.readable = readable
		model.lootable = lootable
		model.link = link

		model.cooldownStart = start
		model.cooldownDuration = duration
		model.cooldownFinish = start + duration

	end,

	updateView = function(self)

		local model = self.model

		local icon = self.icon
		icon:SetTexture(model.texture)
		icon:SetDesaturated(model.locked)

		local count = self.count
		if model.count and model.count > 1 then
			count:SetText(model.count)
		else
			count:SetText("")
		end

		local cooldown = self.cooldown
		CooldownFrame_SetTimer(cooldown, model.cooldownStart, model.cooldownDuration, 1, 0, 0)

		local frame = self.frame
		if model.quality and model.quality > 1 then
			frame:SetBackdropBorderColor(unpack(model.qualityColor))
		else
			frame:SetBackdropBorderColor(0, 0, 0, 0.8)
		end

	end,

	setParent = function(self, parent)
		self.frame:SetParent(parent)
	end,
})

ns.slotComponent = slotComponent

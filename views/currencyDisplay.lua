local addon, ns = ...

local core = Dark.core
local style = core.style
local events = core.events.new()
local ui = core.ui

local config = ns.config


local currencyItem = {

	new = function(self, ...)

		local this = setmetatable({}, { __index = self })
		this:ctor(...)

		return this

	end,

	ctor = function(self, currencyID)


		local frame = CreateFrame("Frame", "$parentItem"..currencyID , UIParent)
		frame:SetSize(50, 15)

		local icon = frame:CreateTexture()
		icon:SetPoint("LEFT", 1, 0)
		icon:SetSize(15, 15)

		local label = ui.createFont(frame)
		label:SetPoint("LEFT", icon, "RIGHT", 1, 0)
		label:SetPoint("RIGHT")
		label:SetHeight(15)

		self.currencyID = currencyID
		self.frame = frame
		self.icon = icon
		self.label = label

	end,

	update = function(self)

		local name, amount, texturePath, earnedThisWeek, weeklyMax, totalMax, isDiscovered = GetCurrencyInfo(self.currencyID)

		self.icon:SetTexture(texturePath)
		self.label:SetText(amount)

	end
}


local currencyDisplay = {
	new = function()

		local frame = CreateFrame("Frame", "DarkBagsCurrency", UIParent)
		frame:SetPoint("BOTTOMLEFT", DarkBagsGold, "TOPLEFT", 0, 4)
		frame:SetPoint("BOTTOMRIGHT", DarkBagsGold, "TOPRIGHT", 0, 4)
		frame:SetHeight(15)

		style.applyBackgroundTo(frame)
		style.addShadow(frame)

		local item = currencyItem:new(823)
		item.frame:SetParent(frame)
		item.frame:SetPoint("LEFT", frame, "LEFT", 0, 0)

		local updateAll = function()
			item:update()
		end

		events.register("CURRENCY_DISPLAY_UPDATE", updateAll)

		updateAll()

	end
}

ns.currencyDisplay = currencyDisplay

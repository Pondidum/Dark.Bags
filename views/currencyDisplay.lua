local addon, ns = ...

local class = ns.lib.class
local events = ns.lib.events

local style = ns.lib.style
local fonts = ns.lib.fonts

local config = ns.config

local currencyItem = class:extend({

	ctor = function(self, currencyID)

		local frame = CreateFrame("Frame", "$parentItem"..currencyID , UIParent)
		frame:SetSize(50, 15)

		local icon = frame:CreateTexture()
		icon:SetPoint("LEFT", 1, 0)
		icon:SetSize(15, 15)

		local label = fonts:create(frame)
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
})

local currencyDisplay = class:extend({

	ctor = function(self)
		self:include(events)

		self:createUI()
		self:CURRENCY_DISPLAY_UPDATE()

	end,

	createUI = function(self)

		local frame = CreateFrame("Frame", "DarkBagsCurrency", UIParent)
		frame:SetPoint("BOTTOMLEFT", DarkBagsGold, "TOPLEFT", 0, 4)
		frame:SetPoint("BOTTOMRIGHT", DarkBagsGold, "TOPRIGHT", 0, 4)
		frame:SetHeight(15)

		style:frame(frame)

		local prev
		local frames = {}

		for i, currencyID in ipairs(config.currencies) do

			local item = currencyItem:new(currencyID)
			item.frame:SetParent(frame)

			if prev then
				item.frame:SetPoint("LEFT", prev, "RIGHT", config.spacing, 0)
			else
				item.frame:SetPoint("LEFT", frame, "LEFT", 0, 0)
			end

			prev = item.frame
			table.insert(frames, item)
		end

		self.frames = frames

	end,

	CURRENCY_DISPLAY_UPDATE = function(self)

		for i, frame in ipairs(self.frames) do
			frame:update()
		end

	end,
})

ns.currencyDisplay = currencyDisplay

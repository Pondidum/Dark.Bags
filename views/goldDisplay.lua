local addon, ns = ...

local style = ns.lib.style
local fonts = ns.lib.fonts

local class = ns.lib.class
local events = ns.lib.events

local goldDisplay = class:extend({

	events = {
		"PLAYER_MONEY",
		"PLAYER_LOGIN",
		"PLAYER_TRADE_MONEY",
		"TRADE_MONEY_CHANGED",
	},

	ctor = function(self)
		self:include(events)
		self:createUI()
	end,

	PLAYER_MONEY = function(self)
		self:updateGold()
	end,

	PLAYER_LOGIN = function(self)
		self:updateGold()
	end,

	PLAYER_TRADE_MONEY = function(self)
		self:updateGold()
	end,

	TRADE_MONEY_CHANGED = function(self)
		self:updateGold()
	end,

	createUI = function(self)

		local frame = CreateFrame("Frame", "DarkBagsGold", UIParent)
		frame:SetPoint("BOTTOMLEFT", DarkBagFrame, "TOPLEFT", 0, 4)
		frame:SetPoint("BOTTOMRIGHT", DarkBagFrame, "TOPRIGHT", 0, 4)
		frame:SetHeight(15)

		style:frame(frame)

		local label = fonts:create(frame)
		label:SetPoint("TOPLEFT", 1, 0)
		label:SetPoint("BOTTOMRIGHT", -1, 0)

		self.label = label

	end,

	updateGold = function(self)
		self.label:SetText(self:getMoneyString(GetMoney(), 12))
	end,

	getMoneyString = function(self, money)

		local goldString, silverString, copperString
		local gold = floor(money / (COPPER_PER_SILVER * SILVER_PER_GOLD))
		local silver = floor((money - (gold * COPPER_PER_SILVER * SILVER_PER_GOLD)) / COPPER_PER_SILVER)
		local copper = mod(money, COPPER_PER_SILVER)

		if ( ENABLE_COLORBLIND_MODE == "1" ) then
			goldString = gold..GOLD_AMOUNT_SYMBOL
			silverString = silver..SILVER_AMOUNT_SYMBOL
			copperString = copper..COPPER_AMOUNT_SYMBOL
		else
			goldString = format(GOLD_AMOUNT_TEXTURE, gold, 0, 0)
			silverString = format(SILVER_AMOUNT_TEXTURE, silver, 0, 0)
			copperString = format(COPPER_AMOUNT_TEXTURE, copper, 0, 0)
		end

		local moneyString = ""
		local separator = ""
		if ( gold > 0 ) then
			moneyString = goldString
			separator = " "
		end
		if ( silver > 0 ) then
			moneyString = moneyString..separator..silverString
			separator = " "
		end
		if ( copper > 0 or moneyString == "" ) then
			moneyString = moneyString..separator..copperString
		end

		return moneyString

	end,

})

ns.goldDisplay = goldDisplay

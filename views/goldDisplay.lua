local addon, ns = ...

local core = Dark.core
local style = ns.lib.style
local events = core.events.new()
local ui = core.ui


local getMoneyString = function(money)

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

end

local goldDisplay = {

	new = function()

		local frame = CreateFrame("Frame", "DarkBagsGold", UIParent)
		frame:SetPoint("BOTTOMLEFT", DarkBagFrame, "TOPLEFT", 0, 4)
		frame:SetPoint("BOTTOMRIGHT", DarkBagFrame, "TOPRIGHT", 0, 4)
		frame:SetHeight(15)

		style:frame(frame)

		local label = ui.createFont(frame)
		label:SetPoint("TOPLEFT", 1, 0)
		label:SetPoint("BOTTOMRIGHT", -1, 0)

		local updateGold = function()
			label:SetText(getMoneyString(GetMoney(), 12))
		end

		events.register("PLAYER_MONEY", updateGold)
		events.register("PLAYER_LOGIN", updateGold)
		events.register("PLAYER_TRADE_MONEY", updateGold)
		events.register("TRADE_MONEY_CHANGED", updateGold)

		updateGold()

	end
}

ns.goldDisplay = goldDisplay

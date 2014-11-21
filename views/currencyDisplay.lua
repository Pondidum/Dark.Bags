local addon, ns = ...

local core = Dark.core
local style = core.style
local events = core.events.new()
local ui = core.ui

local config = ns.config

local currencyDisplay = {
  new = function()

    local frame = CreateFrame("Frame", "DarkBagsCurrency", UIParent)
    frame:SetPoint("BOTTOMLEFT", DarkBagsGold, "TOPLEFT", 0, 4)
    frame:SetPoint("BOTTOMRIGHT", DarkBagsGold, "TOPRIGHT", 0, 4)
    frame:SetHeight(15)

    style.applyBackgroundTo(frame)
    style.addShadow(frame)

    local icon = frame:CreateTexture()
    icon:SetPoint("LEFT", 1, 0)
    icon:SetSize(15, 15)

    local label = ui.createFont(frame)
    label:SetPoint("LEFT", icon, "RIGHT", 1, 0)
    label:SetPoint("RIGHT")
    label:SetHeight(15)

    local update = function()
      local name, amount, texturePath, earnedThisWeek, weeklyMax, totalMax, isDiscovered = GetCurrencyInfo(823)

      icon:SetTexture(texturePath)
      label:SetText(amount)
    end

    events.register("CURRENCY_DISPLAY_UPDATE", update)

    update()

  end
}

ns.currencyDisplay = currencyDisplay

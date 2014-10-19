local addon, ns = ...

local core = Dark.core

local style = core.style
local events = core.events:new()

local config = ns.config
local bar = ns.bar

local bank = ns.controllers.bar:extend({

	name = "Bank",
	container = CreateFrame("Frame", "DarkBankBagFrame", UIParent),

	rows = 1,
	columns = 7,

	init = function(self)

		local parent = BankSlotsFrame

		for i = 1, self.columns do
			table.insert(self.frames, parent["Bag" .. i])
		end

		events.register("PLAYERBANKBAGSLOTS_CHANGED", function() self:updateAll() end)
		events.register("PLAYERBANKSLOTS_CHANGED", function()  self:updateAll() end)

		events.register("BANKFRAME_OPENED", function()
			self.container:Show()
			self:layout()
		end)

		events.register("BANKFRAME_CLOSED", function()
			self.container:Hide()
		end)

		self.container:Hide()
	end,

	customiseFrame = function(self, button)

		button.tooltipText = BANK_BAG

		button:SetParent(self.container)
		button:SetSize(config.buttonSize, config.buttonSize)
		button:Show()

		style.itemButton(button)

		button:SetScript("OnClick", function(this)

		end)

		self:updateButton(button)

	end,

	updateButton = function(self, button)

		local texture = GetInventoryItemTexture("player", button:GetInventorySlot())

		if texture then
			button.icon:SetTexture(texture)
		else
			--lifed from bankFrame.lua: BankFrameItemButton_Update
			local id, slotTextureName = GetInventorySlotInfo("Bag"..button:GetID())
			button.icon:SetTexture(slotTextureName)
		end

	end,
})

ns.bankBar = bank

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


local extraButtons = {

	new = function(self,  ...)

		local this = setmetatable({}, { __index = self })
		this:ctor(...)

		return this
	end,

	ctor = function(self)

		self.frame = CreateFrame("Frame", "DarkBankExtraButtons", UIParent)
		self.frame:SetSize(0, config.buttonSize)

		self:registerEvents()
		self:addButtons()

	end,

	registerEvents = function(self)

		local eventStore = core.events:new()

		eventStore.register("BANKFRAME_OPENED", function()
			self.frame:Show()
		end)

		eventStore.register("BANKFRAME_CLOSED", function()
			self.frame:Hide()
		end)

		self.frame:Hide()

	end,

	addButtons = function(self)

		local button = CreateFrame("Button", "$parentReagents", self.frame, "ActionButtonTemplate")
		button:SetSize(config.buttonSize * 4, config.buttonSize)
		style.actionButton(button)

		local text = core.ui.createFont(button)
		text:SetAllPoints()
		text:SetJustifyH("CENTER")
		text:SetText("Deposit Reagents")

		button:SetScript("OnClick", function(this)
			DepositReagentBank()
		end)

		button:SetPoint("LEFT", config.buttonSize, 0)

		self.frame:SetWidth(self.frame:GetWidth() + config.buttonSize + button:GetWidth())
	end,
}

ns.extraButtons = extraButtons

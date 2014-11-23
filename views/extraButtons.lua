local addon, ns = ...

local core = Dark.core

local style = core.style
local events = core.events:new()

local config = ns.config

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

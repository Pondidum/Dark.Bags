local addon, ns = ...

local style = ns.lib.style
local fonts = ns.lib.fonts

local class = ns.lib.class
local events = ns.lib.events

local config = ns.config

local extraButtons = class:extend({

	events = {
		"BANKFRAME_OPENED",
		"BANKFRAME_CLOSED",
	},

	ctor = function(self)
		self:include(events)
		self:createUI()

	end,

	BANKFRAME_OPENED = function(self)
		self.frame:Show()
	end,

	BANKFRAME_CLOSED = function(self)
		self.frame:Hide()
	end,

	createUI = function(self)

		self.frame = CreateFrame("Frame", "DarkBankExtraButtons", UIParent)
		self.frame:SetSize(0, config.buttonSize)

		local button = CreateFrame("Button", "$parentReagents", self.frame, "ActionButtonTemplate")
		button:SetSize(config.buttonSize * 4, config.buttonSize)
		style:actionButton(button)

		local text = fonts:create(button)
		text:SetAllPoints()
		text:SetJustifyH("CENTER")
		text:SetText("Deposit Reagents")

		button:SetScript("OnClick", function(this)
			DepositReagentBank()
		end)

		button:SetPoint("LEFT", config.buttonSize, 0)

		self.frame:SetWidth(self.frame:GetWidth() + config.buttonSize + button:GetWidth())
		self.frame:Hide()
	end,
})

ns.extraButtons = extraButtons

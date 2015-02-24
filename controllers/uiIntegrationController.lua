local addon, ns = ...

local class = ns.lib.class
local events = ns.lib.events

local integration = class:extend({

	ctor = function(self, bagContainer, bankContainer)
		self:include(events)
		self.bagContainer = bagContainer
		self.bankContainer = bankContainer

		self.originalToggleBackpack = ToggleBackpack
		self.originalToggleBag = ToggleBag
		self.originalToggleAllBags = ToggleAllBags

		self.originalOpenAllBags = OpenAllBags
		self.originalOpenBackpack = OpenBackpack
		self.originalCloseAllBags = CloseAllBags
		self.originalCloseBackpack = CloseBackpack

	end,

	hook = function(self)

		local bagContainer = self.bagContainer
		local bankContainer = self.bankContainer

		tinsert(UISpecialFrames, bagContainer:GetName())

		UIPanelWindows[bankContainer:GetName()] = {area = "left", pushable = 1 }


		local showBag = function()
			bagContainer:Show()
		end

		local hideBag = function()
			bagContainer:Hide()
		end

		local toggleBag = function()
			if bagContainer:IsShown() then
				bagContainer:Hide()
			else
				bagContainer:Show()
			end
		end

		OpenAllBags = showBag
		OpenBackpack = showBag
		CloseAllBags = hideBag
		CloseBackpack = hideBag

		ToggleBackpack = toggleBag
		ToggleAllBags = toggleBag

		BankFrame:UnregisterAllEvents()

		self:register("BANKFRAME_OPENED")
		self:register("BANKFRAME_CLOSED")
		bankContainer:SetScript("OnHide", function() self:hideBank() end)

	end,

	unhook = function(self)

		local bagContainer = self.bagContainer
		local bankContainer = self.bankContainer

		tremove(UISpecialFrames, bagContainer:GetName())

		OpenAllBags = self.originalOpenAllBags
		OpenBackpack = self.originalOpenBackpack
		CloseAllBags = self.originalCloseAllBags
		CloseBackpack = self.originalCloseBackpack

		ToggleBackpack = self.originalToggleBackpack
		ToggleBag = self.originalToggleBag
		ToggleAllBags = self.originalToggleAllBags

		BankFrame:RegisterEvent("BANKFRAME_OPENED")
		BankFrame:RegisterEvent("BANKFRAME_CLOSED")

		self:unregister("BANKFRAME_OPENED")
		self:unregister("BANKFRAME_CLOSED")
		bankContainer:SetScript("OnHide", nil)

	end,

	BANKFRAME_OPENED = function(self)
		self:showBank()
	end,

	BANKFRAME_CLOSED = function(self)
		HideUIPanel(self.bankContainer)
	end,


	showBank = function(self)
		ShowUIPanel(self.bankContainer)
	end,

	hideBank = function(self)
		CloseBankFrame()

		if self.bankContainer:IsShown() then
			HideUIPanel(self.bankContainer)
		end
	end,

})

ns.controllers.uiIntegration = integration

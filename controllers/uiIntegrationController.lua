local addon, ns = ...

local core = Dark.core
local events = core.events.new()

local uiIntegration = {
	
	new = function(bagContainer, bankContainer)

		local originalToggleBackpack = ToggleBackpack
		local originalToggleBag = ToggleBag
		local originalToggleAllBags = ToggleAllBags

		local originalOpenAllBags = OpenAllBags
		local originalOpenBackpack = OpenBackpack
		local originalCloseAllBags = CloseAllBags
		local originalCloseBackpack = CloseBackpack

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

		local showBank = function()
			bankContainer:Show()
		end

		local hideBank = function()
			CloseBankFrame()

			if bankContainer:IsShown() then
				bankContainer:Hide()
			end
		end

		local hook = function()
			tinsert(UISpecialFrames, bagContainer:GetName())
			tinsert(UISpecialFrames, bankContainer:GetName())

			OpenAllBags = showBag
			OpenBackpack = showBag
			CloseAllBags = hideBag
			CloseBackpack = hideBag

			ToggleBackpack = toggleBag
			--ToggleBag = toggleBag
			ToggleAllBags = toggleBag

			BankFrame:UnregisterAllEvents()

			events.register("BANKFRAME_OPENED", showBank)
			events.register("BANKFRAME_CLOSED", function() bankContainer:Hide() end)
			bankContainer:SetScript("OnHide", hideBank)

		end

		local unhook = function()
			tremove(UISpecialFrames, bagContainer:GetName())
			tinsert(UISpecialFrames, bankContainer:GetName())

			OpenAllBags = originalOpenAllBags
			OpenBackpack = originalOpenBackpack
			CloseAllBags = originalCloseAllBags
			CloseBackpack = originalCloseBackpack

			ToggleBackpack = originalToggleBackpack
			ToggleBag = originalToggleBag
			ToggleAllBags = originalToggleAllBags

			BankFrame:RegisterEvent("BANKFRAME_OPENED")
			BankFrame:RegisterEvent("BANKFRAME_CLOSED")

			events.unregister("BANKFRAME_OPENED")
			events.unregister("BANKFRAME_CLOSED")
			bankContainer:SetScript("OnHide", nil)
		end

		local this = {}

		this.hook = hook
		this.unhook = unhook

		return this

	end,

}

ns.controllers.uiIntegration = uiIntegration

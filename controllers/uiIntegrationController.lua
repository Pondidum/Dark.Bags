local addon, ns = ...

local uiIntegration = {
	
	new = function(container)

		local originalToggleBackpack = ToggleBackpack
		local originalToggleBag = ToggleBag
		local originalToggleAllBags = ToggleAllBags

		local originalOpenAllBags = OpenAllBags
		local originalOpenBackpack = OpenBackpack
		local originalCloseAllBags = CloseAllBags
		local originalCloseBackpack = CloseBackpack

		local show = function()
			container:Show()
		end

		local hide = function()
			container:Hide()
		end

		local toggle = function()
			if container:IsShown() then
				container:Hide()
			else
				container:Show()
			end
		end

		local hook = function()
			tinsert(UISpecialFrames, container:GetName())

			OpenAllBags = show
			OpenBackpack = show
			CloseAllBags = hide
			CloseBackpack = hide

			ToggleBackpack = toggle
			ToggleBag = toggle
			ToggleAllBags = toggle

		end

		local unhook = function()
			tremove(UISpecialFrames, container:GetName())

			OpenAllBags = originalOpenAllBags
			OpenBackpack = originalOpenBackpack
			CloseAllBags = originalCloseAllBags
			CloseBackpack = originalCloseBackpack

			ToggleBackpack = originalToggleBackpack
			ToggleBag = originalToggleBag
			ToggleAllBags = originalToggleAllBags

		end

		local this = {}

		this.hook = hook
		this.unhook = unhook

		return this

	end,

}

ns.controllers.uiIntegration = uiIntegration

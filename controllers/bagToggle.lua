local addon, ns = ...

local class = ns.lib.class

local bagToggle = class:extend({

	ctor = function(self, targetFrame)

		self.target = targetFrame

	end,

	hook = function(self)

		local showBag = function()
			self.target:Show()
		end

		local hideBag = function()
			self.target:Hide()
		end

		local toggleBag = function()
			if self.target:IsShown() then
				hideBag()
			else
				showBag()
			end
		end

		tinsert(UISpecialFrames, self.target:GetName())

		hooksecurefunc("OpenAllBags", showBag)
		hooksecurefunc("OpenBackpack", showBag)
		hooksecurefunc("CloseAllBags", hideBag)
		hooksecurefunc("CloseBackpack", hideBag)

		hooksecurefunc("ToggleBackpack", toggleBag)
		hooksecurefunc("ToggleAllBags", toggleBag)

	end,

})

ns.bagToggle = bagToggle
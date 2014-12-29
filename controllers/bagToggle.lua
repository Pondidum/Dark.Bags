local addon, ns = ...

local class = ns.lib.class

local bagToggle = class:extend({

	ctor = function(self, target)

		self.target = target

	end,

	hook = function(self)

		local showBag = function()
			self.target:show()
		end

		local hideBag = function()
			self.target:hide()
		end

		local toggleBag = function()
			self.target:toggle()
		end

		hooksecurefunc("OpenAllBags", showBag)
		hooksecurefunc("OpenBackpack", showBag)
		hooksecurefunc("CloseAllBags", hideBag)
		hooksecurefunc("CloseBackpack", hideBag)

		hooksecurefunc("ToggleBackpack", toggleBag)
		hooksecurefunc("ToggleAllBags", toggleBag)

	end,

})

ns.bagToggle = bagToggle

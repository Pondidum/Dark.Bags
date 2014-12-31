local addon, ns = ...

local class = ns.lib.class
local events = ns.lib.events

local bankToggle = class:extend({

	ctor = function(self, target)
		self.target = target
	end,

	hook = function(self)

		UIPanelWindows[self.target:GetName()] = {area = "left", pushable = 1 }

		self.target:SetScript("OnHide", function()

			CloseBankFrame()

			if self.target:IsShown() then
				HideUIPanel(self.target)
			end

		end)

	end,

	BANKFRAME_OPENED = function(self)
		ShowUIPanel(self.target)
	end,

	BANKFRAME_CLOSED = function(self)
		HideUIPanel(self.target)
	end,
})

ns.bankToggle = bankToggle

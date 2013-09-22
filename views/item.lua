local addon, ns = ...

local core = Dark.core
local style = core.style

ns.views.item = {
	
	new = function(name)
		
		local this = CreateFrame("CheckButton", name, nil, "SecureActionButtonTemplate, SecureHandlerDragTemplate")
		this:SetSize(24, 24)
		
		style.addShadow(this)

		local icon = this:CreateTexture(nil, "HIGH")
		icon:SetAllPoints(this)
		icon:SetTexCoord(.08, .92, .08, .92)

		this.populate = function(details)
			icon:SetTexture(details.texture)

			this:SetID(details.slot)
		end

		this:RegisterForDrag("LeftButton", "RightButton")
		this:RegisterForClicks("AnyUp")

		this:SetScript("OnClick", function(self, button)
			ContainerFrameItemButton_OnClick(this, button)
		end)

		this:SetScript("OnDragStart", function(self, button) 
			ContainerFrameItemButton_OnClick(this, "LeftButton")
		end)

		this:SetScript("OnReceiveDrag", function(self) 
			ContainerFrameItemButton_OnClick(this, "LeftButton")
		end) 

		return this

	end,

}
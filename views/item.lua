local addon, ns = ...

local core = Dark.core
local style = core.style

ns.views.item = {

	new = function(name)

		local this = CreateFrame("CheckButton", name, nil, "ContainerFrameItemButtonTemplate")
		local count = this.count
		local icon = this.icon

		this:SetPushedTexture("")
		this:SetNormalTexture("")
		_G[this:GetName() .."NewItemTexture"]:Hide()

		this:ClearAllPoints()
		this:SetSize(24, 24)

		style.addShadow(this)

		this:Show()

		count:ClearAllPoints()
		count:SetPoint("BottomRight")
		count:Show()

		icon:SetAllPoints(this)
		icon:SetTexCoord(.08, .92, .08, .92)

		this.populate = function(details)
			icon:SetTexture(details.texture)

			if details.count and details.count > 1 then
				count:SetText(details.count)
			else
				count:SetText("")
			end

			this:SetID(details.slot)

		end

		return this

	end,

}
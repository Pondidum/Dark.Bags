local addon, ns = ...

local core = Dark.core
local style = core.style

ns.views.item = {

	new = function(name)

		local this = CreateFrame("CheckButton", name, nil, "ContainerFrameItemButtonTemplate")

		this:SetPushedTexture("")
		this:SetNormalTexture("")
		_G[this:GetName() .."NewItemTexture"]:Hide()

		this:ClearAllPoints()
		this:SetSize(24, 24)

		style.addShadow(this)

		local icon = this.icon
		icon:SetAllPoints(this)
		icon:SetTexCoord(.08, .92, .08, .92)

		this.populate = function(details)
			icon:SetTexture(details.texture)

			this:SetID(details.slot)
			this:Show()
		end

		return this

	end,

}
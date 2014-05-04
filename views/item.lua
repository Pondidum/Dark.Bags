local addon, ns = ...

local core = Dark.core
local style = core.style

ns.views.item = {

	new = function(name)

		local this = CreateFrame("CheckButton", name, nil, "ContainerFrameItemButtonTemplate")
		local count = this.count
		local icon = this.icon
		local cooldown = _G[this:GetName() .."Cooldown"]

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

		local details

		this.setDetails = function(info)
			details = info
		end

		this.populate = function()
			icon:SetTexture(details.texture)

			if details.count and details.count > 1 then
				count:SetText(details.count)
			else
				count:SetText("")
			end

			this:SetID(details.slot)

			CooldownFrame_SetTimer(cooldown, details.cooldownStart, details.cooldownDuration, 1, 0, 0)

			if details.quality and details.quality > ITEM_QUALITY_COMMON then
				this.shadow:SetBackdropBorderColor(unpack(details.qualityColor))
			else
				this.shadow:SetBackdropBorderColor(unpack(core.colors.shadow))
			end

		end

		return this

	end,

}
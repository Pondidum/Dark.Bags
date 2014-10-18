local addon, ns = ...

local core = Dark.core
local style = core.style

local config = ns.config

ns.views.item = {

	new = function(name)

		local this = CreateFrame("CheckButton", name, UIParent, "BankItemButtonGenericTemplate")
		local count = this.Count
		local icon = this.icon
		local cooldown = _G[this:GetName() .."Cooldown"]

		this:SetPushedTexture("")
		this:SetNormalTexture("")

		this:ClearAllPoints()
		this:SetSize(config.buttonSize, config.buttonSize)

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

			if details.quality and details.quality > 1 then
				this.shadow:SetBackdropBorderColor(unpack(details.qualityColor))
			else
				this.shadow:SetBackdropBorderColor(unpack(core.colors.shadow))
			end

			icon:SetDesaturated(details.locked)

		end

		this:SetScript('OnEnter', function (frame)

			if details.link then
				GameTooltip:SetOwner(frame, "ANCHOR_RIGHT")
				GameTooltip:SetHyperlink(details.link)
			else
				GameTooltip:Hide()
			end

		end)

		this:SetScript('OnLeave', function (frame)

			GameTooltip:Hide()
			ResetCursor()

		end)

		return this

	end,

}
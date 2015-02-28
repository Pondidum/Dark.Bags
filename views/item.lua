local addon, ns = ...

local core = Dark.core
local style = ns.lib.style

local config = ns.config

ns.views.item = {

	new = function(name)

		local this = CreateFrame("CheckButton", name, UIParent, "ContainerFrameItemButtonTemplate")
		local count = this.Count
		local icon = this.icon
		local cooldown = _G[this:GetName() .."Cooldown"]

		this:SetPushedTexture("")
		this:SetNormalTexture("")

		this:ClearAllPoints()
		this:SetSize(config.buttonSize, config.buttonSize)

		style:border(this)

		this.BattlepayItemTexture:SetTexture(nil)
		this.BattlepayItemTexture:Hide()
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

			this.count = details.count
			this:SetID(details.slot)

			CooldownFrame_SetTimer(cooldown, details.cooldownStart, details.cooldownDuration, 1, 0, 0)

			if details.quality and details.quality > 1 then
				this.shadow:SetBackdropBorderColor(unpack(details.qualityColor))
			else
				this.shadow:SetBackdropBorderColor(unpack(core.colors.shadow))
			end

			icon:SetDesaturated(details.locked)

		end

		local onEnter = function (frame)

			if details.link then
				GameTooltip:SetOwner(frame, "ANCHOR_RIGHT")

				--eeeeeewwww. why does SetBagItem have to be so crap
				if details.bag == BANK_CONTAINER then
					GameTooltip:SetHyperlink(details.link)
				else
					GameTooltip:SetBagItem(details.bag, details.slot)
				end

			else
				GameTooltip:Hide()
			end

			if IsModifiedClick("DRESSUP") and details.link then
				ShowInspectCursor()

			elseif MerchantFrame:IsShown() and MerchantFrame.selectedTab == 1 then
				ShowContainerSellCursor(details.bag, details.slot)

			elseif details.readable then
				ShowInspectCursor()

			else
				ResetCursor()
			end

		end

		local onLeave = function (frame)

			GameTooltip:Hide()
			ResetCursor()

		end

		this.UpdateTooltip = onEnter

		this:SetScript('OnEnter', onEnter)
		this:SetScript('OnLeave', OnLeave)

		return this

	end,

}
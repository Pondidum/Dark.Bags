local addon, ns = ...

local core = Dark.core
local style = core.style

local group = ns.group
local views = ns.views

views.bagContainer = {

	new = function(name, parent)

		local layoutOptions = {
			wrap = true,
			marginBottom = 4,
			marginTop = 4
		}

		local this = group:new(name, parent, layoutOptions)
		local bags = {}

		local buildOrGetGroup = function(bagID)

			if not bags[bagID] then

				local group = views.bagGroup.new(name .. "Bag" .. bagID, this.frame, bagID)
				group.frame:SetPoint("LEFT")
				group.frame:SetPoint("RIGHT")

				style.addBackground(group.frame)
				style.addShadow(group.frame)

				this:add(group)
				bags[bagID] = group
			end

			return bags[bagID]

		end

		this.populate = function(model)

			for bagID, contents in pairs(model) do

				buildOrGetGroup(bagID).populate(contents)

			end

			this.frame.performLayout()

		end

		this.update = function()

			for bagID, group in pairs(bags) do
				group.update()
			end

		end


		return this

	end

}

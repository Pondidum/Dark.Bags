local addon, ns = ...

local core = Dark.core
local style = core.style

local group = ns.group
local views = ns.views

views.bagContainer = {

	new = function(name, parent, bagStart, bagFinish)

		local layoutOptions = {
			wrap = true,
			marginBottom = 4,
			marginTop = 4
		}

		local this = group:new(name, parent, layoutOptions)
		local bags = {}

		for bagID = bagStart, bagFinish do

			local group = views.bagGroup.new(name .. "Bag" .. bagID, this.frame, bagID)
			group.frame:SetPoint("LEFT")
			group.frame:SetPoint("RIGHT")

			style.addBackground(group.frame)
			style.addShadow(group.frame)

			this:add(group)
			bags[bagID] = group

		end

		this.populate = function(model)

			for bagID, group in pairs(bags) do

				local contents = model.getContents(bagID)

				group.populate(contents)

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

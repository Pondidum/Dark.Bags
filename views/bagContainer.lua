local addon, ns = ...

local core = Dark.core
local style = core.style

local group = ns.group
local views = ns.views

views.bagContainer = {

	new = function(name, parent, model, bagStart, bagFinish)

		local layoutOptions = {
			wrap = true,
			marginBottom = 4,
			marginTop = 4
		}

		local this = group:new(name, parent, layoutOptions)
		local bags = {}

		for bagID = bagStart, bagFinish do

			local sub = views.bagGroup.new(name .. "Bag" .. bagID, this.frame, model, bagID)
			sub.frame:SetPoint("LEFT")
			sub.frame:SetPoint("RIGHT")

			style.addBackground(sub.frame)
			style.addShadow(sub.frame)

			this:add(sub)
			table.insert(bags, sub)

		end

		this.populate = function()

			for i = 1, #bags do
				bags[i].populate()
			end

			this.frame.performLayout()

		end

		this.update = function()

			for i = 1, #bags do
				bags[i].update()
			end

		end


		return this

	end

}

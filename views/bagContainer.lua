local addon, ns = ...

local model = ns.model
local group = ns.group
local views = ns.views

local bagContainer = {
	
	new = function(name, parent, bagStart, bagFinish)

		local this = group:new(name, parent)
		local bags = {}

		for bagID = bagStart, bagFinish do
			
			local sub = views.bagGroup.new(name .. "Bag" .. bagID, this.frame, bagID)

			this:add(sub)			
			table.insert(bags, sub)

		end
			
		this.populate = function()

			for i = 1, #bags do
				bags[i].populate()
			end

		end

		return this

	end

}

ns.views.bagContainer = bagContainer
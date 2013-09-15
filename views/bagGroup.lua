local addon, ns = ...

local model = ns.model
local group = ns.group

views.bagContainer = {
	
	new = function(name, parent, bagNumber)

		local this = group:new(name, parent)

		this.populate = function()

			this:clear()

			local contents = model.getContents(bagNumber)

			for k, details in pairs(contents) do
				
				local item = this:addItem()
				
				item.populate(details)

			end

		end

		return this

	end

}

ns.views.bagGroup = bagGroup

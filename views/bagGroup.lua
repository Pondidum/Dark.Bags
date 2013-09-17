local addon, ns = ...

local group = ns.group
local views = ns.views

views.bagGroup = {
	
	new = function(name, parent, model, bagNumber)

		local this = group:new(name, parent, { wrap = true, autosize = true })

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

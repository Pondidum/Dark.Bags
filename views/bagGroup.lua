local addon, ns = ...

local group = ns.group
local views = ns.views

views.bagGroup = {

	new = function(name, parent, itemViewCache, bagNumber)

		local this = group:new(name, parent, { wrap = true, autosize = true })
		local entries = {}

		this.populate = function(contents)

			this:clear()
			table.wipe(entries)

			this.frame:SetID(bagNumber)

			for k, details in pairs(contents) do

				local item = itemViewCache.get()
				item:SetParent(this.frame)

				item.setDetails(details)
				item.populate()

				table.insert(entries, item)
				this:add(item)
			end

		end

		this.update = function()

			for i = 1, #entries do
				entries[i].populate()
			end

		end

		return this

	end

}

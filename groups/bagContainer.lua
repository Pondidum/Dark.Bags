local addon, ns = ...

local style = ns.lib.style

local group = ns.group
local groups = ns.groups

groups.bagContainer = {

	new = function(name, parent, itemViewCache)

		local layoutOptions = {
			wrap = true,
			marginBottom = 4,
			marginTop = 4
		}

		local this = group:new(name, parent, layoutOptions)
		local childGroups = {}

		local buildOrGetGroup = function(bagID)

			if not childGroups[bagID] then

				local group = groups.bagGroup.new(name .. "Bag" .. bagID, this.frame, itemViewCache, bagID)
				group.frame:SetPoint("LEFT")
				group.frame:SetPoint("RIGHT")

				style:frame(group.frame)

				this:add(group)
				childGroups[bagID] = group
			end

			return childGroups[bagID]

		end

		this.populate = function(model)

			for bagID, contents in model do

				buildOrGetGroup(bagID).populate(contents)

			end

			this.frame.performLayout()

		end

		this.update = function()

			for bagID, group in pairs(childGroups) do
				group.update()
			end

		end


		return this

	end

}

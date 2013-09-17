local addon, ns = ...

local core = Dark.core
local layout = core.layout
local style = core.style

local group = {
	
	new = function(self, name, parent, options)

		local frame = CreateFrame("Frame", name, parent)
		layout.init(frame, options)

		-- style.addBackground(frame)
		-- style.addShadow(frame)


		local this = setmetatable({}, { __index = self })

		this.frame = frame

		return this 

	end, 

	clear = function(self) 

		self.frame.clear()

	end,

	addItem = function(self) 

		local item = ns.bagItemCache.get()
		local frame = self.frame

		item:SetParent(frame)
		frame.add(item)

		return item

	end,

	add = function(self, subGroup)

		local frame = self.frame

		frame.add(subGroup.frame)

	end,

}

ns.group = group

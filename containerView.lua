local addon, ns = ...

local containerView = {
	
	new = function()

		local this = {
			isShown = false,
			show = function() end,
			hide = function() end,
		}

		return this 

	end

}

ns.containerView = containerView
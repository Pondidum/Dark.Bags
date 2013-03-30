local addon, ns = ...
local events = Dark.core.events

local containerController = {
	
	new = function(model, view)


		local openBags = function()
			view.show()
		end

		local closeBags = function()
			view.hide()
		end

		local toggleBags = function()
			if view.isShown then
				view.hide()
			else
				view.show()
			end
		end

		local bagViewCache = cache.new(function()  --[[ create ]] end)

		local update = function()

			for bagID, bag in pairs(model.bags) do 

				local view = bagViewCache.get()
				
			end

		end

		--overwrite blizzard functions
		ToggleBackpack = toggleBags
		ToggleBag = toggleBags
		ToggleAllBags = toggleBags

		OpenAllBags = openBags
		OpenBackpack = openBags
		CloseAllBags = closeBags
		CloseBackpack = closeBags

	end,

}

ns.containerController = containerController
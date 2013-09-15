local addon, ns = ...
local core = Dark.core
local events = core.events.new()

local BACKPACK_CONTAINER = BACKPACK_CONTAINER
local NUM_BAG_SLOTS = NUM_BAG_SLOTS

local model = {

	new = function()

		local storage = {}
		local listeners = {}

		local hasChanged = function(first, second)

			for key, value in pairs(first) do
				
				if second[key] ~= value then
					return false
				end

			end

			return true
			
		end

		local scanBag = function(bag)

			storage[bag] = storage[bag] or {}

			local changedSlots = {}

			for slot = 1, GetContainerNumSlots(bag) do

				local texture, count, locked, quality, readable, lootable, link = GetContainerItemInfo(bag, slot)
				local existing = storage[bag][slot]

				local info = {
					texture = texture,
					count = count,
					locked = locked,
					quality = quality,
					readable = readable,
					lootable = lootable,
					link = link,
				}

				if existing == nil or hasChanged(existing, info) then
					
					storage[bag][slot] = info	
					table.insert(changedSlots, slot)

				end				

			end

			return changedSlots

		end

		local notify = function(changedSlots)

			for i, listener in ipairs(listeners) do
				listener(changedSlots)
			end

		end

		local scan = function()

			local changes = {}

			for bag = BACKPACK_CONTAINER, NUM_BAG_SLOTS do

				changes[bag] = scanBag(bag)

			end

			notify(changes)

		end

		events.register("BAG_UPDATE_DELAYED", scan)
		
		local this = {}

		this.addListener = function(listener)
			table.insert(listeners, listener)
		end

		this.getContents = function(bag)
			return storage[bag] or {}	--i trust me to not modify the table by refrence...
		end

		return this 

	end,
}

ns.model = model
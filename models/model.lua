local addon, ns = ...

local core = Dark.core
local events = core.events.new()

local BACKPACK_CONTAINER = BACKPACK_CONTAINER
local NUM_BAG_SLOTS = NUM_BAG_SLOTS

local classifiers = ns.classifiers

local model = {

	new = function()

		local storage = {}
		local listeners = {}

		local hasChanged = function(first, second)

			for key, value in pairs(first) do
				
				if second[key] ~= value then
					return true
				end

			end

			return false
			
		end

		local scan = function()

			classifiers.beforeClassify()

			for bag = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
				
				storage[bag] = storage[bag] or {}

				for slot = 1, GetContainerNumSlots(bag) do

					local texture, count, locked, quality, readable, lootable, link = GetContainerItemInfo(bag, slot)
					local info = storage[bag][slot] or {}

					info.texture = texture
					info.count = count
					info.locked = locked
					info.quality = quality
					info.readable = readable
					info.lootable = lootable
					info.link = link
					info.bag = bag
					info.slot = slot

					info.tags = info.tags or {}

					classifiers.classify(info)

					storage[bag][slot] = info				

				end

			end

			classifiers.afterClassify()
			
			for i, listener in ipairs(listeners) do
				listener()
			end

		end

		events.register("BAG_UPDATE_DELAYED", scan)
		classifiers.onRescanRequested(scan)
		
		local this = {}

		this.addListener = function(listener)
			table.insert(listeners, listener)
		end

		this.getContents = function(bag)
			return storage[bag] or {}	--i trust me to not modify the table by refrence...
		end

		this.getByTag = function(tag)

			local results = {}

			for bagID, contents in pairs(storage) do

				for slotID, item in pairs(contents) do

					if item.tags[tag] then
						table.insert(results, item)
					end

				end

			end

			return results

		end

		return this 

	end,
}

ns.model = model
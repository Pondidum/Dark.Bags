local addon, ns = ...

local core = Dark.core
local events = core.events.new()

local BACKPACK_CONTAINER = BACKPACK_CONTAINER
local NUM_BAG_SLOTS = NUM_BAG_SLOTS

local classifiers = ns.classifiers
local itemModel = ns.itemModel

local model = {

	new = function()

		local this = {}
		local storage = {}

		local scan = function()

			classifiers.beforeClassify()

			for bag = BACKPACK_CONTAINER, NUM_BAG_SLOTS do

				storage[bag] = storage[bag] or {}

				for slot = 1, GetContainerNumSlots(bag) do

					local info = storage[bag][slot] or itemModel:new(bag, slot)

					info:update()

					classifiers.classify(info)

					storage[bag][slot] = info

				end

			end

			classifiers.afterClassify()

			this.onContentsChanged()

		end

		events.register("BAG_UPDATE_DELAYED", scan)
		classifiers.onRescanRequested(scan)

		this.onContentsChanged = function()
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
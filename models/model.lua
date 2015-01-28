local addon, ns = ...

local core = Dark.core

local itemModel = ns.itemModel

local model = {

	new = function(containerIDs)

		local events = core.events.new()
		local this = {}
		local storage = {}

		local quickScan = function()

			classifiers.beforeClassify()

				for bagID, slots in pairs(storage) do
					for slotID, contents in pairs(slots) do
						contents:update()
						contents:classify(classifiers)
					end
				end

			classifiers.afterClassify()

		end

		local fullRescan = function()

			for i, bag in ipairs(containerIDs) do

				storage[bag] = storage[bag] or {}

				for slot = 1, GetContainerNumSlots(bag) do

					local info = storage[bag][slot] or itemModel:new(bag, slot)

					info:update()

					storage[bag][slot] = info

				end

			end

			this.onContentsChanged()

		end

		local onCooldownsUpdated = function()
			quickScan()
			this.onCooldownsUpdated()
		end

		events.register("BAG_UPDATE_DELAYED", fullRescan)
		events.register("BANKFRAME_OPENED", fullRescan)
		events.register("BAG_UPDATE_COOLDOWN", onCooldownsUpdated)
		events.register("ITEM_LOCK_CHANGED", onCooldownsUpdated)

		--classifiers.onRescanRequested(fullRescan)

		this.onContentsChanged = function()
		end

		this.onCooldownsUpdated = function()
		end

		this.getContents = function()

			local current = 0

			return function()

				current = current + 1

				local containerID = containerIDs[current]

				if not containerID or not storage[containerID] then
					return nil
				end

				return containerID, storage[containerID] --i trust me to not modify the table by refrence...
			end

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
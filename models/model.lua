local addon, ns = ...

local core = Dark.core

local classifiers = ns.classifiers
local itemModel = ns.itemModel

local model = {

	new = function(startRange, finishRange)

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

			classifiers.beforeClassify()

			for bag = startRange, finishRange do

				storage[bag] = storage[bag] or {}

				for slot = 1, GetContainerNumSlots(bag) do

					local info = storage[bag][slot] or itemModel:new(bag, slot)

					info:update()
					info:classify(classifiers)

					storage[bag][slot] = info

				end

			end

			classifiers.afterClassify()

			this.onContentsChanged()

		end

		local onCooldownsUpdated = function()
			quickScan()
			this.onCooldownsUpdated()
		end

		events.register("BAG_UPDATE_DELAYED", fullRescan)
		events.register("BAG_UPDATE_COOLDOWN", onCooldownsUpdated)
		events.register("ITEM_LOCK_CHANGED", onCooldownsUpdated)

		--classifiers.onRescanRequested(fullRescan)

		this.onContentsChanged = function()
		end

		this.onCooldownsUpdated = function()
		end

		this.getContents = function()

			local current = startRange - 1

			return function()

				current = current + 1

				if not storage[current] then
					return nil
				end

				return current, storage[current] --i trust me to not modify the table by refrence...
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
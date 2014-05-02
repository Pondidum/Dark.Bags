local addon, ns = ...

local setLocations = {}

ns.classifiers.new(function(this)

	this.addRescanEvent("EQUIPMENT_SETS_CHANGED")

	this.beforeClassify = function()

		table.wipe(setLocations)

		for i = 1, GetNumEquipmentSets() do

			local setName, icon, setID = GetEquipmentSetInfo(i)
			local items = GetEquipmentSetLocations(setName)

			for k, v in pairs(items) do

				local player, bank, bags, location, slot, bag = EquipmentManager_UnpackLocation(v)

				if bag then
					local key = bag ..":".. slot

					setLocations[key] = setLocations[key] or {}
					setLocations[key][setName] = true
				end

			end

		end

	end

	this.classify = function(details)

 		local location = setLocations[details.bag ..":".. details.slot]

		if location then

			details.tags["EQUIPMENTSET"] = true

			for key, value in pairs(location) do
				details.tags["EQUIPMENTSET:"..key] = true
			end

		else

			for key, v in pairs(details.tags) do

				if key:match("^EQUIPMENTSET:") then
					details.tags[v]	= nil
				end

			end

		end

	end

	this.afterClassify = function()
		table.wipe(setLocations)
	end

end)

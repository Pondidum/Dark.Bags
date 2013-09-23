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

				setLocations[bag] = setLocations[bag] or {}
				setLocations[bag][slot] = setName

			end

		end

	end

	this.classify = function(details)

		local set = setLocations[details.bag][details.slot]

		if set then 
			details.tags["EQUIPMENTSET"] = true
			details.tags["EQUIPMENTSET:"..set] = true
		end

	end

	this.afterClassify = function()
		table.wipe(setLocations)
	end

end)

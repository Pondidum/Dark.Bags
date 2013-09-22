local addon, ns = ...

local core = Dark.core
local events = core.eventStore.new()

local TAG = "EQUIPMENTSET"

local equipmentSet = {
	
	new = function()

		local this = classifier:new()
		this:addRescanEvent("EQUIPMENT_SETS_CHANGED")

		local setLocations = {}

		this.beforeClassify = function(self)

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

		this.classify = function(self, details)

			local set = setLocations[details.bag][details.slot]

			if set then 
				details.tags[TAG] = true
				details.tags[TAG..":"..set] = true
			end

		end

		this.afterClassify = function(self)
			table.wipe(setLocations)
		end

		return this
	end,
}
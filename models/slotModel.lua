BACKPACK_CONTAINER, NUM_BAG_SLOTS

REAGENTBANK_CONTAINER,
BANK_CONTAINER
NUM_BAG_SLOTS + 1, NUM_BAG_SLOTS + NUM_BANKBAGSLOTS



local start = 0
local finish = 0 
local slots = {}

for bagID = start, finish do

	local bagFrame = CreateFrame("Frame", "DarkBagsBag"..bagID, UIParent)
	bagFrame:Hide()
	bagFrame:SetID(bagID)

	local slots = GetContainerNumSlots(bagID)

	for slotID = 1, slots do

		local slot = slotComponent:new(bagID, slotID)
		slot:setParent(bagFrame)

		table.insert(slots, slot)

	end

end
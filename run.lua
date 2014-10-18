local addon, ns = ...

local run = function()

	local pack = ns.bagContainerSet:new()
	local bank = ns.bankContainerSet:new()

	local ui = ns.controllers.uiIntegration.new(pack.frame, bank.frame)
	ui.hook()

	local gold = ns.goldDisplay.new()
	local bankBar = ns.bankBar

end

run()
Dark.bags = ns
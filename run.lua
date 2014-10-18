local addon, ns = ...

local sets = ns.sets

local run = function()

	local pack = sets.bag:new()
	local bank = sets.bank:new()

	local ui = ns.controllers.uiIntegration.new(pack.frame, bank.frame)
	ui.hook()

	local gold = ns.goldDisplay.new()
	local bankBar = ns.bankBar

end

run()
Dark.bags = ns
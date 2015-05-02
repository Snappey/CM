
local money = {}
money.enabled = true
money.priority = 4

-- TODO: Save players money

function money.LoadModule()
	if money.enabled then
		CM.includeDir(CM.Modules.Dir .. "/money/cl", "", "init.lua")
		CM.includeDir(CM.Modules.Dir .. "/money/sv", CM.Modules.Dir .. "/money/sv", "init.lua")
	end
end

CM.AddModule("Money", money.LoadModule, money)
 


local HUD = {}
HUD.enabled = true
HUD.priority = 3

function HUD.LoadModule()
	if HUD.enabled then
		CM.includeDir(CM.Modules.Dir .. "/HUD/cl", "", "init.lua")
		CM.includeDir(CM.Modules.Dir .. "/HUD/sv", CM.Modules.Dir .. "/HUD/sv", "init.lua")
	end
end

CM.AddModule("HUD", HUD.LoadModule, HUD)
 
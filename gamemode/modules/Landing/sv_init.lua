

local landing = {}
landing.enabled = true
landing.priority = 3

function landing.LoadModule()
	if landing.enabled then
		CM.includeDir(CM.Modules.Dir .. "/landing/cl", "", "init.lua")
		CM.includeDir(CM.Modules.Dir .. "/landing/sv", CM.Modules.Dir .. "/landing/sv", "init.lua")
	end
end

CM.AddModule("Landing", landing.LoadModule, landing)
 
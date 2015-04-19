
local Main = {}
Main.enabled = true


function Main.LoadModule()
	if Main.enabled then
		CM.includeDir(CM.Modules.Dir .. "/Ma/cl", "", "init.lua")
		CM.includeDir(CM.Modules.Dir .. "/Main/sv", CM.Modules.Dir .. "/Main/sv", "init.lua")
	end
end

CM.AddModule("Main", Main.LoadModule, Main) 
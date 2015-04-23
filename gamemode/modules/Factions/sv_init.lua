local factions = {}
factions.enabled = true
factions.priority = 1

function factions.LoadModule()
	if factions.enabled then
		CM.includeDir(CM.Modules.Dir .. "/factions/cl", "", "init.lua")
		CM.includeDir(CM.Modules.Dir .. "/factions/sv", CM.Modules.Dir .. "/factions/sv", "init.lua")
	end
end

CM.AddModule("Factions", factions.LoadModule, factions)
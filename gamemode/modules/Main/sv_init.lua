
local Main = {}
Main.enabled = true
Main.priority = 2

-- TODO: Link more modules together, this module sets the entire gamemode up e.g. implement the round system
-- Think about how many players are needed to start a round

function Main.LoadModule()
	if Main.enabled then
		CM.includeDir(CM.Modules.Dir .. "/Ma/cl", "", "init.lua")
		CM.includeDir(CM.Modules.Dir .. "/Main/sv", CM.Modules.Dir .. "/Main/sv", "init.lua")
	end
end

CM.AddModule("Main", Main.LoadModule, Main) 
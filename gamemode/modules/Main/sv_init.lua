
local Main = {}
Main.enabled = true
Main.priority = 2
Main.override = false -- Debug stuff

-- For the game to start at least 3 people need to be included, however they are free to roam but a round will not start till 3 people join

function Main.LoadModule()
	if Main.enabled then
		CM.includeDir(CM.Modules.Dir .. "/Ma/cl", "", "init.lua")
		CM.includeDir(CM.Modules.Dir .. "/Main/sv", CM.Modules.Dir .. "/Main/sv", "init.lua")
	end
end

CM.AddModule("Main", Main.LoadModule, Main) 
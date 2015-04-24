
local scoring = {}
scoring.position = {}
scoring.enabled = true
scoring.priority = 3

-- TODO: Add client layer for huds, implement into the main module

function scoring.LoadModule()
	if scoring.enabled then
		CM.includeDir(CM.Modules.Dir .. "/Scoring/cl", "", "init.lua")
		CM.includeDir(CM.Modules.Dir .. "/Scoring/sv", CM.Modules.Dir .. "/Scoring/sv", "init.lua")
	end
end

CM.AddModule("Scoring", scoring.LoadModule, scoring)

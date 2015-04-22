
local scoring = {}
scoring.enabled = true
scoring.score = {}
scoring.priority = 3

function scoring.LoadModule()
	if scoring.enabled then
		CM.includeDir(CM.Modules.Dir .. "/Scoring/cl", "", "init.lua")
		CM.includeDir(CM.Modules.Dir .. "/Scoring/sv", CM.Modules.Dir .. "/Scoring/sv", "init.lua")
	end
end

CM.AddModule("Scoring", scoring.LoadModule, scoring)

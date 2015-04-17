
local rounds = {}
rounds.enabled = true

function rounds.Init()


end

function rounds.LoadModule()
	if rounds.enabled then
		CM.includeDir(CM.Modules.Dir .. "/rounds/cl", "", "init.lua")
		CM.includeDir(CM.Modules.Dir .. "/rounds/sv", CM.Modules.Dir .. "/rounds/sv", "init.lua")
	end
end

rounds.Init()
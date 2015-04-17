
local testing = {}
testing.enabled = true

function testing.Init()

end

function testing.LoadModule()
	if testing.enabled then
		CM.includeDir(CM.Modules.Dir .. "/testing/cl", "", "init.lua")
		CM.includeDir(CM.Modules.Dir .. "/testing/sv", CM.Modules.Dir .. "/testing/sv", "init.lua")
	end
end

CM.AddModule("testing",	testing.LoadModule, {})

testing.Init()
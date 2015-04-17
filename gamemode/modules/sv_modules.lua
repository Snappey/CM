
CM.Modules = {}
CM.Modules.Dir = "CM/Gamemode/modules"

function CM.AddModule(name, entrypoint, moduleinfo)
	if type(name) != "string" || type(entrypoint) != "string" || type(moduleinfo) != "table" then return end
	if !table.HasValue(table.GetKeys(CM.Modules), name) then 
		moduleinfo.entry = entrypoint
		CM.Modules[name] = moduleinfo
		MsgC(Color(0,250,0), "INFO: ", Color(255,255,255), "Module '" .. name ..  "' added! \n")
	else
		MsgC(Color(250,0,0), "ERROR: ", Color(255,255,255),  "Module '" .. name .. "' already added! \n")
	end
end

function CM.LoadAddedModules()
	for k,v in pairs(CM.Modules) do
		if (k == "Dir") then continue end
		CM.include(CM.Modules.Dir .. "/" .. k .. "/" .. v.entry, "")
	end
end

-- Gets a list of all folders which have a valid entry point to load the module
function CM.GetModules()
local _,dirs = file.Find(CM.Modules.Dir.."/*", "LUA")
local tbl = {}
	for k,v in pairs(dirs) do
		table.insert(tbl,1, v)
	end
	return tbl
end

CM.AddModule("testing", "init.lua", {})
CM.AddModule("Rounds", "init.lua", {})


CM.LoadAddedModules()
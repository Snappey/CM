
CM.Modules = {}
CM.Modules.Dir = "CM/Gamemode/modules"

function CM.AddModule(name, entrypoint, moduleinfo)
	if type(name) != "string" || type(entrypoint) != "function" || type(moduleinfo) != "table" then return end
	if !table.HasValue(table.GetKeys(CM.Modules), name) then 
		moduleinfo.entry = entrypoint
		CM.Modules[name] = moduleinfo
		MsgC(Color(0,250,0), "INFO: ", Color(255,255,255), "Module '" .. name ..  "' added! \n")
	else
		MsgC(Color(250,0,0), "ERROR: ", Color(255,255,255),  "Module '" .. name .. "' already added! \n")
	end
end

function CM.LoadModules()
	root = CM.Modules.Dir
	local _,dirs = file.Find(root.."/*","LUA")
--	CM.includeDir(root,"", fileCalled)

	for k,v in pairs(dirs) do -- Loads all dirs inside the root
		CM.includeDir(root.."/"..v,root.."/"..v, "sv_modules.lua")
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


-- Use inside a module to move a table of values to the global table
-- Moves the table to CM.Modules.'Module' Where 'Module' is the name of the module
function CM.ExportVars(tbl)

	for k,v in pairs(tbl) do

	end
end

CM.LoadModules()
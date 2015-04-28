
CM.Modules = {}
CM.Modules.Dir = "CM/Gamemode/modules"

function CM.AddModule(name, entrypoint, moduleinfo)
	if type(name) != "string" or type(entrypoint) != "function" or type(moduleinfo) != "table" then return end
	if !table.HasValue(table.GetKeys(CM.Modules), name) then
		moduleinfo.entry = entrypoint
		moduleinfo.name = name
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

function CM.RunModules()
	for k,v in ipairs(CM.loadOrder) do
		v()
	end
end

CM.loadOrder = {}
function CM.SortModules()
	for k,v in pairs(CM.Modules) do
		if type(v) != "table" then continue end
		if v.priority == nil then v.priority = 10 end
		table.insert(CM.loadOrder, v.priority, v.entry)
	end	
end

CM.LoadModules()

CM.SortModules()
 
CM.RunModules() -- Remove this to prevent themodules from being included

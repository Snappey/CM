
CM = {}

function CM.Init()
 	CM.LoadCoreCL("cl_init.lua")
end

function CM.LoadCoreCL(fileCalled)
local root = "CM/gamemode"
local _,dirs = file.Find(root.."/*","LUA")
	CM.includeDir(root,"", fileCalled)

	for k,v in pairs(dirs) do -- Loads all dirs inside the root
		CM.includeDir(root.."/"..v,v)
	end
end	

function CM.includeDir(root,dir, fileCalled)
local files, dirs = file.Find(root.."/*","LUA")
root = root.. "/" 
	for k,v in pairs(dirs) do
		CM.includeDir(root..v)
	end
	for k,v in pairs(files) do
		if v == fileCalled then continue end
		include(root..v, dir)
	end
end


CM.Init() 
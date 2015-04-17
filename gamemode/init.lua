
CM = {} -- Global Table, store functions etc. include
CM.LoadedFiles = {}

function CM.Init()
	hook.Call("PreInit") -- Called before the gamemode starts loading
	openingStuff()
	CM.LoadBaseFiles("init.lua") -- Load base files, e.g. cl_init, shared, anything in the main dir
	CM.PostInit()
end

function CM.PostInit()

	CM.includeDir("CM/Gamemode/modules", "CM/Gamemode/modules", "init.lua")
	hook.Call("PostInit") -- Allows you to attach hooks to the event e.g. hook.Add("PostInit", "testing", function)
end

function CM.includeDir(root,dir, fileCalled)
local files = file.Find(root.."/*","LUA")
	for k,v in pairs(files) do
		if v == fileCalled then continue end
		if string.find(v,"cl_",1,true) then
			AddCSLuaFile(dir.."/"..v, dir)
		elseif string.find(v,"sv_",1,true) then
			CM.include(dir.."/"..v, dir)
		elseif string.find(v,"sh_",1,true) then
			CM.include(dir.."/"..v, dir)
			AddCSLuaFile(dir.."/"..v)
		end
	end
end

function CM.LoadBaseFiles(fileCalled)
local root = "CM/gamemode"
local _,dirs = file.Find(root.."/*","LUA")
	CM.includeDir(root,"", fileCalled)

	--[[for k,v in pairs(dirs) do -- Loads all dirs inside the root
		CM.includeDir(root.."/"..v,v)
	end --]]
end

function CM.include(str,dir)
	include(str)
	MsgC(Color(250,250,250) , "File: ", Color(0,250,0), str, Color(250,250,250) , " Included!\n")
	table.insert(CM.LoadedFiles,1,str)
end


function openingStuff()
	MsgC(Color(0,240,0), " \n \n - Gamemode Citymayhem Loading! - \n")

end 

CM.Init() -- Gamemode is ran as soon as init.lua is ran

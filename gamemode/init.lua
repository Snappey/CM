
CM = {} -- Global Table, store functions etc. include
CM.LoadedFiles = {}

function CM.Init()
	CM.LoadBaseFiles() -- Load base files, e.g. cl_init, shared, anything in the main dir

end

function CM.includeDir(root,dir)
local files = file.Find(root.."/*","LUA")
	for k,v in pairs(files) do
		if v == "init.lua" then continue end
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

function CM.LoadBaseFiles()
local root = "CM/gamemode"
local _,dirs = file.Find(root.."/*","LUA")
	CM.includeDir(root,"")
	for k,v in pairs(dirs) do
		CM.includeDir(root.."/"..v,v)
	end 
end

function CM.include(str,dir)
	include(str)
	MsgC(Color(250,250,250) , "File: ", Color(0,250,0), str, Color(250,250,250) , " Included!\n")
	table.insert(CM.LoadedFiles,1,str)
end

CM.Init() -- Gamemode is ran as soon as init.lua is ran
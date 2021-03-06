

--[[-----------------------------------------------------------------------------]]
  --			Commands/Chat Commands Base
--[[-----------------------------------------------------------------------------]]

CM.Commands = {}
CM.Commands.Chat = {}
chatcommand = {}

CM.Commands.Prefix = {"!","/"}

function CM.createCommand(name,desc,consolecommand,chatcmd,callback)

	CM.Commands[name] = {
		name = name,
		desc = desc,
		callback = callback,
		consolecommand = consolecommand,
		chatcmd = chatcmd
	}

	if concommand then
		concommand.Add(name,callback) -- Create Console Command
	end 

	if chatcommand then 
		chatcommand.Add(name,callback)
	end
end

function chatcommand.Add(name,callback)
	CM.Commands.Chat[name] = callback
end

hook.Add("PlayerSay","CMChatCommands",function(ply,str,tmcht)
	if tmcht then return end
local str = string.lower(str)

	if string.Contains(str,CM.Commands.Prefix) then
		for k,v in pairs(CM.Commands.Chat) do
			if str == k then
				v()
				return ""
			end
		end
		return ""
	end
end)

--[[-----------------------------------------------------------------------------]]
  --			Random shiz
--[[-----------------------------------------------------------------------------]]

function string.Contains(str,needle)
	if type(needle) == "table" then
		for i=1,#needle do
			if string.find(str,needle[i] ,1,false) then
				return true 
			end
		end
		return false
	elseif type(needle) == "string" then
		if string.find(str,needle,1,false) then
			return true
		end
		return false
	end
end

chat = {}

function chat.AddText(...)

end
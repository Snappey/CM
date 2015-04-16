
--[[---------------------------------------------------------

  This file should contain variables and functions that are
   the same on both client and server.

  This file will get sent to the client - so don't add
   anything to this file that you don't want them to be
   able to see.

-----------------------------------------------------------]]

GM.Name			= "City Mayhem"
GM.Author		= "Spaggle"
GM.Email		= ""
GM.Website		= "www.citymayhem.net"
GM.TeamBased	= false


function GM:OnReloaded()
	CM.LoadBaseFiles("sh_shared.lua")
	MsgC(Color(0,250,0), "Gamemode Reloaded.")
end
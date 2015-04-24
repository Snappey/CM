local Main = CM.Modules["Main"]

Main.Factions = {}

function Main.Init()
	Main.SetupFactions()
	--Main.ConnecToDB()
end

function Main.SetupFactions()
	Main.CreateFactions()

	Main.FactionLoadout()
end


concommand.Add("ForceLoadout", function(ply,cmd,args)
	Main.Loadout(ply)
end)

hook.Add("PostInit", "AfterEverythingHasLoaded", function()
	Main.Init()
end)

CM.Modules["Main"] = Main
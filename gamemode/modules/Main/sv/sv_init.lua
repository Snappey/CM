local Main = CM.Modules["Main"]

Main.Factions = {}

function Main.Init()
	Main.SetupFactions()
	
end

function Main.SetupFactions()
	Main.CreateFactions()

	Main.FactionLoadout()
end


concommand.Add("ForceLoadout", function(ply,cmd,args)
	Main.Loadout(ply)
end)

Main.Init()

CM.Modules["Main"] = Main
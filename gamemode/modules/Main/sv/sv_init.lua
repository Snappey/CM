local Main = CM.Modules["Main"]

Main.Factions = {}

function Main.Init()
	Main.SetupFactions()

end

function Main.SetupFactions()
	Main.CreateFactions()

	Main.FactionLoadout()
end


hook.Add("PostInit", "KickStartGamemode", function() -- Start the main module once core has finished loading
	Main.Init()
end)

concommand.Add("ForceLoadout", function(ply,cmd,args)
	Main.Loadout(ply)
end)

CM.Modules["Main"] = Main
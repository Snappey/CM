local Main = CM.Modules["Main"]

Main.Factions = {}

function Main.Init()
	Main.SetupFactions()

end

function Main.SetupFactions()
	Main.Factions["City Rebels"] = faction.Create("City Rebels")
	Main.Factions["Mafia"] = faction.Create("Mafia")
	Main.Factions["Government"] = faction.Create("Government")

	Main.FactionLoadout()
end

function Main.FactionLoadout()
	Main.Factions["City Rebels"]:SetLoadout( {"weapon_crowbar"} )

	Main.Factions["Mafia"]:SetLoadout( {"weapon_crowbar"} )

	Main.Factions["Government"]:SetLoadout( {"weapon_crowbar"} )
	print("OLO")
end

hook.Add("PostInit", "KickStartGamemode", function() -- Start the main module once core has finished loading
	Main.Init()
end)

CM.Modules["Main"] = Main
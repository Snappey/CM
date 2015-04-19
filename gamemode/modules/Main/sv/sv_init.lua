local Main = CM.Modules["Main"]

Main.Factions = {}

function Main.Init()
	Main.SetupFactions()

end

function Main.SetupFactions()
	Main.Factions["City Rebels"] = faction.Create("City Rebels")
	Main.Factions["Mafia"] = faction.Create("Mafia")
	Main.Factions["Government"] = faction.Create("Government")
end

hook.Add("PostInit", "KickStartGamemode", function() -- Start the main module once core has finished loading
	Main.Init()
end)

CM.Modules["Main"] = Main
local Main = CM.Modules["Main"]

Main.Factions = {}

function Main.Init()
	Main.SetupFactions()
	Main.ConnectToDB()
	timer.Create("CMWaitingForRound", 20, 0, Main.Start) -- This wont start till a bot or player joins
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
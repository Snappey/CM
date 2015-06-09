local Hooks = CM.Modules["Main"]

util.AddNetworkString("CMOnPlayerSpawn")

function Hooks.OnPlayerSpawn(ply)
	ply.money = 0 -- Moved from sv_money.lua  in moeny module
	timer.Simple(3, function()
		net.Start("CMOnPlayerSpawn")
		net.Send(ply) -- Trigger the landing menu on the client
	end)
	ply:SetFaction(math.random(1,3))
	Hooks.PlayerExists(ply)
	Hooks.GetPlayerDetails(ply)
end
hook.Add("PlayerInitialSpawn", "CMOnPlayerSpawn", Hooks.OnPlayerSpawn)

function Hooks.OnPlayerLeave(ply)
	Hooks.SavePlayerDetails(ply)
end
hook.Add("PlayerDisconnected", "CMOnPlayerDisconnect", Hooks.OnPlayerLeave)

function Hooks.PlayerSpawn(ply)

end


CM.Modules["Main"] = Hooks

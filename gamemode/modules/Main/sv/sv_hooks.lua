local Hooks = CM.Modules["Main"]

util.AddNetworkString("CMOnPlayerSpawn")

function Hooks.OnPlayerSpawn(ply)
	net.Start("CMOnPlayerSpawn")
	net.Send(ply) -- Trigger the landing menu on the client
	ply:SetFaction(math.random(1,3))
end
hook.Add("PlayerInitialSpawn", "CMOnPlayerSpawn", Hooks.OnPlayerSpawn)

function Hooks.PlayerSpawn(ply)

end


CM.Modules["Main"] = Hooks

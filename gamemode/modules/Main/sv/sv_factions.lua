local Factions = CM.Modules["Main"]


function Factions.CreateFactions()
	Factions.Factions["City Rebels"] = faction.Create("City Rebels")
	Factions.Factions["Mafia"] = faction.Create("Mafia")
	Factions.Factions["Government"] = faction.Create("Government")
end

function Factions.FactionLoadout()
	Factions.Factions["City Rebels"]:SetLoadout( {"weapon_crowbar"} )
	
	Factions.Factions["Mafia"]:SetLoadout( {"weapon_crowbar"} )

	Factions.Factions["Government"]:SetLoadout( {"weapon_crowbar"} )
end

function Factions.Loadout(ply)
	if ply:GetFaction() == 0 then MsgC(Color(255,255,255),"INFO: ", Color(0,255,0), "Attempted to give player loadout, no assigned faction!\n") return end
	for k,v in pairs(Factions.Factions[ply:GetFactionName()].loadout) do
		ply:Give(v)
	end
end
hook.Add("PlayerLoadout", "GiveWeaponsToFaction", Factions.Loadout)


CM.Modules["Main"] = Factions
local Factions = CM.Modules["Factions"]
local ply = FindMetaTable("Player")

function ply:SetFaction(faction)
	if table.HasValue(table.GetKeys(CM.Modules["Main"].Factions), faction) then
		ply.Faction = CM.Modules["Main"].Factions[faction].id
	end 
end

function ply:GetFaction()
	return ply.Faction
end

concommand.Add("SetFaction", function(ply, cmd, args) -- Debug shiz
	if IsValid(ply) then
		print(ply:Alive())
		ply:SetFaction("City Rebels")
	end
end)
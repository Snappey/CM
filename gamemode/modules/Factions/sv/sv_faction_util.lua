local Factions = CM.Modules["Factions"]
local ply = FindMetaTable("Player")

function ply:SetFaction(faction)
	if type(faction) == "string" then
		if table.HasValue(table.GetKeys(CM.Modules["Main"].Factions), faction) then
			ply.Faction = CM.Modules["Main"].Factions[faction].id
			return
		end 
	elseif type(faction) == "number" then
		for k,v in pairs(CM.Modules["Main"].Factions) do
			if v.id == faction then
				ply.Faction = v.id
				return
			end
		end
	end
	ErrorNoHalt("ERROR: Faction name or id does not exist!")
end

function ply:GetFaction()
	return ply.Faction
end

function ply.GetFactionName()
	for k,v in pairs(CM.Modules["Main"].Factions) do
		if ply.Faction == v.id then
			return k
		end
	end
end

concommand.Add("SetFaction", function(ply, cmd, args) -- Debug shiz
	if IsValid(ply) then
		ply:SetFaction(2)
	end
end)
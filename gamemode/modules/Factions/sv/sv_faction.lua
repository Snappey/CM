faction = {}
faction.__index = faction
faction.id = 0

function faction.Create(name)
	local fctn = {}
	setmetatable(fctn, faction)
	fctn.name = name
	fctn.loadout = {}
	faction.id = faction.id + 1; fctn.id = faction.id
	return fctn
end

function faction.SetLoadout(tbl)

end

function faction.SetColour(r,g,b)

end
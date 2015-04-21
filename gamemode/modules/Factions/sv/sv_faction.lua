faction = {}
faction.__index = faction
faction.id = 0

function faction.Create(name)
	local fctn = {}
	setmetatable(fctn, faction)
	fctn.name = name
	fctn.loadout = {}
	fctn.attributes = function() end
	fctn.colour = Color(0,0,0)
	faction.id = faction.id + 1; fctn.id = faction.id
	return fctn
end

function faction:SetLoadout(tbl)	
	self.loadout = tbl
end

function faction:AddWeapon(wep)
	table.insert(self.loadout, 1, wep)
end

function faction:SetColour(r,g,b)
	faction.colour = Color(r,g,b)
end
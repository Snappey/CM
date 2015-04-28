
local money = CM.Modules["Money"]
local ply = FindMetaTable("Player")

util.AddNetworkString("GiveMoneyRequest")

function ply:AddMoney(val)
	if val < 0 then return ErrorNoHalt("AddMoney only takes positive values!") end
	self.money = self.money + val
end

function ply:TakeMoney(val)
	if val < 0 then return ErrorNoHalt("TakeMoney only takes positive values!") end
	self.money = self.money - val
end

function ply:GetMoney()
	return self.money
end

function ply:GiveMoney(ply, val)
	if val < 0 then return ErrorNoHalt("GiveMoney only takes positive values!") end
	self.money = self.money - val
	ply.money = ply.money + val
end

function money.OnGiveRequest(_, ply)
local val = net.ReadInt(32)
local ent = ply:GetEyeTrace().Entity
	if (ent:IsPlayer()) && ply.money >= val then
		ply:GiveMoney(ent, val)
	end
end
net.Receive("GiveMoneyRequest", money.OnGiveRequest)
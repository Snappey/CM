
CM.Money = {}

local ply = LocalPlayer()

function ply:GetMoney()
	return self.money
end

function ply:GiveMoney(val) -- Gives money to the player you are looking at
	if ply != nil && val != nil then
		net.Start("GiveMoneyRequest")
		net.WriteInt(val, 32)
		net.SendToServer()
	end
end
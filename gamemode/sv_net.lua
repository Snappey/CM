
util.AddNetworkString("CMClientRequest")
util.AddNetworkString("CMClientSend")

function CM.ClientRequest(_,ply)
local tmp = {ent = ply, money = ply.money, faction = ply:GetFactionName() } -- adapt it to later send more stuff that needs networking
	net.Start("CMClientSend")
		net.WriteTable(tmp)
	net.Send(ply)
end
net.Receive("CMClientRequest", CM.ClientRequest)
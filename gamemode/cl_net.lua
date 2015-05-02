
CM.vars = {}

function CM.OnClientReceive() -- This needs to be cleaned up
local tbl = net.ReadTable()
	if tbl.ent != LocalPlayer() then return end
	CM.vars = tbl
	LocalPlayer().money = CM.vars["money"]
end
net.Receive("CMClientSend", CM.OnClientReceive)


concommand.Add("NetTest", function(ply,cmd,args)
	net.Start("CMClientRequest")
	net.SendToServer()
end)

net.Receive("CMOnPlayerSpawn", function()
	local Frame = vgui.Create("DFrame") -- Proof of concept, just debug stuff
	Frame:Center()
	Frame:MakePopup()
	Frame:SetSize(200,400)
end)

concommand.Add("sup", function()
	print("Yeah its working")
end)
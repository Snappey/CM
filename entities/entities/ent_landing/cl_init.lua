
include("shared.lua")

local function PointOnCircle( ang, radius, offX, offY )
	ang = math.rad( ang )
	local x = math.cos( ang ) * radius + offX
	local y = math.sin( ang ) * radius + offY
	return x, y
end

local numSquares = 12 --How many squares do we want to draw? Thanks to trig tutorial on gmod wiki
local interval = 360 / numSquares
local centerX, centerY = 0, 10
local radius = 20

surface.CreateFont("Trebuchet20",{font="Trebuchet",size=20,weight=700 })

function ENT:Draw()
	self:DrawModel()	
end

function ENT:LoadGUI()
	if ( frame ) then frame:Remove() for _, pnl in ipairs( frames ) do pnl:Remove() end end
	frames = {}

	self.Tabs = {
	["Home"] = {
		["BasePanel"] = "DPanel",
		["bg"] = Color(208,206,212)
		},
	["Score"] = {
		["BasePanel"] = "DPanel",
		["bg"] = Color(208,206,212)
	},
	["Test"] = {
		["BasePanel"] = "DPanel",
		["bg"] = Color(208,206,212)
	},
}

	frame = vgui.Create( "DFrame" )
	frame:SetPos( 275, 0 )
	frame:SetSize( 50,0 ) -- 600, 350
	frame:SetTitle( "" )
	frame:SetDraggable(false)
	frame:ShowCloseButton(false)


	local loading = vgui.Create("DPanel", frame)
	loading:SetPos(22,10)
	loading:SetSize(70,70)
	loading.done = false

	loading.Paint = function(pnl,w,h)
		if !loading.done then
			radius = math.sin(CurTime()) * 10
			for degrees = 1, 360, interval do --Start at 1, go to 360, and skip forward at even intervals.
			local x, y = PointOnCircle( degrees, radius, centerX, centerY )
			draw.RoundedBox( 4, x, y, 6, 6, Color( 255,255,255, 200 ) )
			end
		end
	end

	frame.Paint = function(pnl, w, h)
		surface.SetDrawColor(45,45,45, 225)
		surface.DrawRect(0,0,w,h)
	end

	frame:SizeTo(-1, 350, 3, 0, 1, nil)

	frame:SizeTo(600,350,5,3,1,nil )

	loading:MoveTo(300,10,5,3,1,nil)
	frame:MoveTo(0,0,5,3,1,nil)

	loading:AlphaTo(0,2,6.2,function()
		loading.done = true
		self:CreateGUI()
	end)
	--	Drawing

	hook.Add( "PostDrawOpaqueRenderables", "DrawSample3D2DFrame2", function()	
		vgui.Start3D2D( self:GetPos() + (self:GetRight() * 7) - (self:GetForward() * 90) + (self:GetUp() * 5), Angle( 0,0,90 ), 0.3 )
			frame:Paint3D2D()
			
			for _, frame in ipairs( frames ) do
				frame:Paint3D2D()
			end
		vgui.End3D2D()
	end )
end

function ENT:CreateGUI()

	local w,h = frame:GetWide(), frame:GetTall()


	local Title = vgui.Create("DLabel", frame)
	Title:SetPos(w*0.2 + 50, 4)
	Title:SetSize(300,20)
	Title:SetText("")

	Title.Paint = function(pnl,w,h)
		draw.DrawText("CityMayhem - Control Panel", "Trebuchet24", 0,0,Color(245,245,245), TEXT_ALIGN_LEFT)
	end

	local topRightTime = vgui.Create("DLabel", frame)
	topRightTime:SetPos(w - 5, 2)
	topRightTime:SetSize(40,20)
	topRightTime:SetText("")

	topRightTime.Paint = function(pnl,w,h)
		draw.DrawText(os.date( "%X" , os.time() ), "Trebuchet18", 0,0,Color(245,245,245), TEXT_ALIGN_RIGHT)
	end

	 MainPanel = vgui.Create("DPropertySheet", frame)
	MainPanel:SetPos(w*0.2 + 20, 50)
	MainPanel:SetSize((frame:GetWide() - (w*0.2 + 10)) - 20, 275)

	MainPanel.Paint = function(pnl,w,h)
		surface.SetDrawColor(89,113,227)
		surface.DrawOutlinedRect(0,0,w,h)
	end


	self:CreateTabs(self.Tabs)
end


function ENT:CreateTabs(tbl)
	if tbl == nil || type(tbl) != "table" then return end
	PrintTable(tbl)
	local i = 13
	for k,v in pairs(self.Tabs) do

		 v.panel = vgui.Create(v.BasePanel)
		 v.panel.Paint = function(pnl,w,h) surface.SetDrawColor(31,31,31); surface.DrawRect(0,-20,w,h+20) end

		 v.sheet = MainPanel:AddSheet("",v.panel,nil)
	
		 
		 local Title = vgui.Create("DLabel", v.panel)
		 Title:SetPos(20,-10)
		 Title:SetFont("Trebuchet24")
		 Title:SetText(k)


		 --[[  Create Sidebar button ]]--
		local btn = vgui.Create("DButton", frame)
		btn:SetSize(110,30)
		btn:SetText("")
		btn:SetPos(20, i* 4)

		btn.DoClick = function() MainPanel:SetActiveTab(v.sheet.Tab) end

		btn.Paint = function(pnl,w,h)
			if !pnl.Depressed then
				surface.SetDrawColor(89,113,227)
			else
				surface.SetDrawColor(227,70,76)
			end
			surface.DrawRect(0,0,w,h)
			draw.DrawText(k, "Trebuchet20", w*0.47,4,Color(245,245,245), TEXT_ALIGN_CENTER)
		end
		 --[[  End of Sidebar button ]]--


		i = i + 10
	end

	for k,v in pairs(MainPanel.Items) do
		if(!v.Tab) then continue end
		v.Tab.Paint = function(pnl,w,h)  end
	end
end


function ENT:OnRemove()
	hook.Remove("PostDrawOpaqueRenderables", "DrawSample3D2DFrame2")
end

function ENT:Initialize()
	self:LoadGUI()
end

concommand.Add("RestartAnimation", function()
	hook.Remove("PostDrawOpaqueRenderables", "DrawSample3D2DFrame2")
	ents.FindByClass("ent_landing")[1]:LoadGUI()
end)


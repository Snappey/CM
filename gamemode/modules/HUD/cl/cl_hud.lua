
CM.HUD = {}
CM.HUD.Components = {}
CM.HUD.hide ={
	CHudHealth = true,
	CHudBattery = true,
	CHudCrosshair = true,
	CHudAmmo = true,
	CHudSecondaryAmmo =true
}

hook.Add( "HUDShouldDraw", "HideHUD", function( name )
	if ( CM.HUD.hide[ name ] ) then
		return false
	end
	-- Don't return anything here, it may break other addons that rely on this hook.
end )

surface.CreateFont("Health", {font="Tahoma", size = 24, weight = 700} )
surface.CreateFont("HealthCross", {font="Tahoma", size = 48, weight = 3600, bold = true})
surface.CreateFont("Position", {font="Tahoma", size = 24, Weight = 700})
surface.CreateFont("PrimaryAmmo", {font="Tahoma", size = 54, weight = 900})
surface.CreateFont("SecAmmo", {font="Tahoma", size = 32, weight = 700})
surface.CreateFont("Objective", {font="Tahoma", size = 22, weigh = 700})

local ply = LocalPlayer()
local w,h = ScrW(), ScrH()

function CM.HUD.Draw(pos, ang, scale)
	if !IsValid(ply) || !ply:Alive()  then return end
	CM.HUD.Components.Left()
	CM.HUD.Components.Right()
end

function CM.HUD.Components.Left()

	 -- Base Elements
	surface.SetDrawColor(45,45,45, 230)
		surface.DrawRect(50, h - 310, 300,210)
	surface.SetDrawColor(208,206,212, 240)
		surface.DrawRect(50,(h - 170 )+ 70, 300, 8)

	-- Position / Callout

	surface.SetFont("Position")
		surface.SetTextPos(50, h - 87)
		surface.SetTextColor(208,206,212)
		surface.DrawText("Callout / Position")


	-- Minimap Dot

	surface.DrawCircle(203,h - 205, 5, Color(277,70,76))



	-- Info Panel

	surface.SetDrawColor(45,45,45, 230)
		surface.DrawRect(50, 30, 420, 60)

	surface.SetFont("Objective")
		surface.SetTextPos(60,35)
		surface.SetTextColor(208,206,212)
		surface.DrawText("Current Objective:")

end

function CM.HUD.Components.Right()

	local clip = ply:GetActiveWeapon():Clip1() || 0
	local ammo = ply:GetAmmoCount(ply:GetActiveWeapon():GetPrimaryAmmoType()) + ply:GetActiveWeapon():Clip1() or 0

	local health = ply:Health() || 0
	local oldHealth = 0

	if clip == -1 then
		clip = 0
	end
	if ammo == -1 then
		ammo = 0
	end

	if health < oldHealth then
		health = health - 1
	end

	-- Base Elements

	surface.SetDrawColor(45,45,45,120)
		surface.DrawRect( w - 280, h - 200, 240, 120)
	surface.SetDrawColor(208,206,2012, 230)
		surface.DrawRect( w - 280, h - 120, 240, 2)


	-- Ammo

	surface.SetFont("PrimaryAmmo")
		surface.SetTextPos(w - 230, h - 190)
		surface.SetTextColor(45,45,45, 60)
		surface.DrawText("000")

	surface.SetFont("PrimaryAmmo")
		surface.SetTextPos(w - 230, h - 190)
		surface.SetTextColor(208,206, 212)
		surface.DrawText(clip)

	surface.SetFont("SecAmmo")
		surface.SetTextPos(w - 145, h -165)
		surface.SetTextColor(208,206,212)
		surface.DrawText("/")

		surface.SetTextPos( w - 120, h - 165)
		surface.DrawText(ammo)

	-- Health

	surface.SetDrawColor(208,206,212)
		surface.DrawTexturedRect(w - 235, h - 93, 190 * (health / 100), 8, 180)

	surface.SetFont("Health")
		surface.SetTextPos(w - 235, h - 117)
		surface.SetTextColor(208,206,212)
		surface.DrawText(health)

	surface.SetFont("HealthCross")
		surface.SetTextPos(w - 273, h - 125)
		surface.SetTextColor(227,70,76)
		surface.DrawText("+")


		oldHealth = health
end

local mmX, mmY = 50, h - 310

function CM.HUD.Components.Minimap()
	-- Draw Stuff on HUD
end


function CM.HUD.Project()
	CM.HUD.Draw()
end
hook.Add("HUDPaint", "ProjectHUD", CM.HUD.Project)
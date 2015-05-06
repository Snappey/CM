
CM.hud = {}
CM.hud.hide ={
	CHudHealth = true,
	CHudBattery = true,
	CHudCrosshair = true
}

hook.Add( "HUDShouldDraw", "HideHUD", function( name )
	if ( CM.hud.hide[ name ] ) then
		return false
	end
	-- Don't return anything here, it may break other addons that rely on this hook.
end )
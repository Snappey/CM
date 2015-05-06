--[[
	
3D2D VGUI Wrapper
Copyright (c) 2015 Alexander Overvoorde, Matt Stevens

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

]]--

local origin = Vector(0, 0, 0)
local angle = Vector(0, 0, 0)
local normal = Vector(0, 0, 0)
local scale = 0

-- Helper functions

local function planeLineIntersect( lineStart, lineEnd, planeNormal, planePoint )
	local t = planeNormal:Dot( planePoint - lineStart ) / planeNormal:Dot( lineEnd - lineStart )
	return lineStart + t * ( lineEnd - lineStart )
end

local function getCursorPos()
	local p = planeLineIntersect( LocalPlayer():EyePos(), LocalPlayer():EyePos() + LocalPlayer():GetAimVector() * 250 , normal, origin )
	--local p = util.IntersectRayWithPlane(LocalPlayer():EyePos(), LocalPlayer():GetAimVector(), origin, normal)
	--print(p)
	local offset = origin - p

	local angle2 = angle:Angle()
	angle2:RotateAroundAxis( normal, 90 )
	angle2 = angle2:Forward()
	
	local x = Vector( offset.x * angle.x, offset.y * angle.y, offset.z * angle.z ):Length()
	local y = Vector( offset.x * angle2.x, offset.y * angle2.y, offset.z * angle2.z ):Length()

	return x, y
end

local function getParents( pnl )
	local parents = {}
	local parent = pnl.Parent
	while ( parent ) do
		table.insert( parents, parent )
		parent = parent.Parent
	end
	return parents
end

local function absolutePanelPos( pnl )
	local x, y = pnl:GetPos()
	local parents = getParents( pnl )
	
	for _, parent in ipairs( parents ) do
		local px, py = parent:GetPos()
		x = x + px
		y = y + py
	end
	
	return x, y
end

local function pointInsidePanel( pnl, x, y )
	local px, py = absolutePanelPos( pnl )
	local sx, sy = pnl:GetSize()

	x = x / scale
	y = y / scale

	return x >= px and y >= py and x <= px + sx and y <= py + sy
end

-- Input

local inputWindows = {}

local function isMouseOver( pnl )
	return pointInsidePanel( pnl, getCursorPos() )
end

local function postPanelEvent( pnl, event, ... )
	if ( not pnl:IsValid() or not pointInsidePanel( pnl, getCursorPos() ) ) then return false end
	
	local handled = false
	
	for child in pairs( pnl.Childs or {} ) do
		if ( postPanelEvent( child, event, ... ) ) then
			handled = true
			break
		end
	end
	
	if ( not handled and pnl[ event ] ) then
		pnl[ event ]( pnl, ... )
		return true
	else
		return false
	end
end

local function checkHover( pnl )
	pnl.WasHovered = pnl.Hovered
	pnl.Hovered = isMouseOver( pnl )
	
	if not pnl.WasHovered and pnl.Hovered then
		if pnl.OnCursorEntered then pnl:OnCursorEntered() end
	elseif pnl.WasHovered and not pnl.Hovered then
		if pnl.OnCursorExited then pnl:OnCursorExited() end
	end

	for child, _ in pairs( pnl.Childs or {} ) do
		if ( child:IsValid() ) then checkHover( child ) end
	end
end

-- Mouse input

hook.Add( "KeyPress", "VGUI3D2DMousePress", function( _, key )
	if ( key == IN_USE ) || (input.IsMouseDown(MOUSE_LEFT)) then
		for pnl in pairs( inputWindows ) do
			if ( pnl:IsValid() ) then
				origin = pnl.Origin
				scale = pnl.Scale
				angle = pnl.Angle
				normal = pnl.Normal
				
				postPanelEvent( pnl, "OnMousePressed", MOUSE_LEFT )
			end
		end
	end
end )

hook.Add( "KeyRelease", "VGUI3D2DMouseRelease", function( _, key )
	if ( key == IN_USE ) || !(input.IsMouseDown(MOUSE_LEFT)) then
		for pnl in pairs( inputWindows ) do
			if ( pnl:IsValid() ) then
				origin = pnl.Origin
				scale = pnl.Scale
				angle = pnl.Angle
				normal = pnl.Normal
				
				postPanelEvent( pnl, "OnMouseReleased", MOUSE_LEFT )
			end
		end
	end
end )

-- Key input

-- TODO, OH DEAR.
-- Drawing:

function vgui.Start3D2D( pos, ang, res )
	origin = pos
	scale = res
	angle = ang:Forward()
	
	normal = Angle( ang.p, ang.y, ang.r )
	normal:RotateAroundAxis( ang:Forward(), -90 )
	normal:RotateAroundAxis( ang:Right(), 90 )
	normal = normal:Forward()
	
	cam.Start3D2D( pos, ang, res )
end

local _R = debug.getregistry()
function _R.Panel:Paint3D2D()
	if not self:IsValid() then return end
	
	-- Add it to the list of windows to receive input
	inputWindows[ self ] = true

	-- Override gui.MouseX and gui.MouseY for certain stuff
	local oldMouseX = gui.MouseX
	local oldMouseY = gui.MouseY
	local cx, cy = getCursorPos()

	function gui.MouseX()
		return cx / scale
	end
	function gui.MouseY()	
		return cy / scale
	end
	
	-- Override think of DFrame's to correct the mouse pos by changing the active orientation
	if self.Think then
		if not self.OThink then
			self.OThink = self.Think
			
			self.Think = function()
				origin = self.Origin
				scale = self.Scale
				angle = self.Angle
				normal = self.Normal
				
				self:OThink()
			end
		end
	end
	
	-- Update the hover state of controls
	checkHover( self )
	
	-- Store the orientation of the window to calculate the position outside the render loop
	self.Origin = origin
	self.Scale = scale
	self.Angle = angle
	self.Normal = normal

	
	-- Draw it manually
	self:SetPaintedManually( false )
		self:PaintManual()

		surface.SetDrawColor(245,245,245)
		surface.DrawLine(gui.MouseX(), gui.MouseY() - 5 , gui.MouseX(), gui.MouseY() + 5)
		surface.DrawLine(gui.MouseX() - 5, gui.MouseY() , gui.MouseX() + 5, gui.MouseY())

	self:SetPaintedManually( true )

	gui.MouseX = oldMouseX
	gui.MouseY = oldMouseY

end

function vgui.End3D2D()
	cam.End3D2D()
end

-- Keep track of child controls

if not vguiCreate then vguiCreate = vgui.Create end
function vgui.Create( class, parent )
	local pnl = vguiCreate( class, parent )
	
	pnl.Parent = parent
	pnl.Class = class
	
	if parent then
		if not parent.Childs then parent.Childs = {} end
		parent.Childs[ pnl ] = true
	end
	
	return pnl
end
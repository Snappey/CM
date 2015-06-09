AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")


function ENT:Initialize()

	self:SetModel( "models/mechanics/solid_steel/i_beam2_8.mdl" ) -- models/props_lab/workspace002.mdl -- models/Items/ammocrate_ar2.mdl
	self:PhysicsInit( SOLID_VPHYSICS )  
	self:SetMoveType( MOVETYPE_NONE)
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType(SIMPLE_USE)

	local phys = self:GetPhysicsObject()
		if (phys:IsValid()) then
			phys:Wake()
		end
end

function ENT:Use(activator,caller)

end


function ENT:Think()

end


function ENT:SpawnFunction( ply, tr, ClassName )
	if (  !tr.Hit ) then return end

	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	local ent = ents.Create( ClassName )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()

	return ent
end



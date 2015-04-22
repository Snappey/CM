local ply = FindMetaTable("Player")

function ply:AddScore(val)
	if type(val) != "number" then return end
	self.score = self.score + val
end

function ply:SetScore()
	if type(val) != "number" then return end
	self.score = val
end

function ply:GetScore()
	return self.score
end

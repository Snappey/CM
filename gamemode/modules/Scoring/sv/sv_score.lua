local scoring = CM.Modules["Scoring"]


function scoring.ResetFactionScore()
	for k,v in pairs(CM.Modules["Main"].Factions) do
		v.score = 0
	end
end

function scoring.GetTopFaction()
local tmp = 0
	for k,v in pairs(CM.Modules["Main"].Factions) do
		if v.score > tmp then
			tmp = v
		end
	end
	return tmp
end

function scoring.GetTopPlayer()
local tmp = 0
	for k,v in pairs(player.GetAll()) do
		if v.score > tmp then
			tmp = v
		end
	end
	return tmp
end

-- Used to reset every players score
function scoring.ResetPlayerScore()
	for k,v in pairs(player.GetAll()) do
		v.score = 0
	end
end

scoring.ResetFactionScore() -- On module load reset score etc. loads factions into table aswell

CM.Modules["Scoring"]  = scoring
local scoring = CM.Modules["Scoring"]


function scoring.ResetFactionScore()
	for k,v in pairs(CM.Modules["Main"].Factions) do
		scoring.score[k] = 0
	end
end


scoring.ResetFactionScore() -- On module load reset score etc. loads factions into table aswell

CM.Modules["Scoring"]  = scoring
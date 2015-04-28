
local Rounds = CM.Modules["Main"]
local timers = CM.Modules["Rounds"]

function Rounds.CheckPlayers()
	if #player.GetAll() > 3 then
		return true
	end
	return false
end

function Rounds.Start()
	if Rounds.CheckPlayers() || Rounds.override == true then
		timers.StartRound()
		MsgC(Color(255,255,255), "INFO: ", Color(0,255,0), "Round has started!")
		timer.Remove("CMWaitingForRound")
		return
	end
		MsgC(Color(255,255,255), "INFO: ", Color(0,255,0), "Not enough players waiting for more!")
		timer.Remove("CMWaitingForRound")
end


hook.Add("RoundFinished", "RoundInfoFinished", function()
	MsgC(Color(255,255,255), "INFO: ", Color(0,255,0), "Round has Finished!")
	timer.Create("CMWaitingForRound", 600, 0, Main.Start)
end)

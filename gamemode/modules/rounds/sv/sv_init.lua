local round = CM.Modules["Rounds"]


function round.StartRound()
	if round.ongoing then MsgC(Color(255,0,0) , "ERROR: ", Color(250,250,250), "Round already started, stop the current one before starting another!") return end

	print(round.timer, round.tick, round.tickTotal, round.length)
	timer.Create(round.timer, round.tick, round.tickTotal, round.Tick)
	timer.Create("RoundFinished", round.length, 0, round.Finished)

	round.ongoing = true
end

function round.Tick()
	hook.Call("RoundTick")
	MsgC("INFO: ",Color(0,255,0), " Round tick completed! \n")
end

function round.Finished()
	hook.Call("RoundFinished")
	round.Stop()
end

function round.Stop()
	if timer.Exists(round.timer) || timer.Exists("RoundFinished") then
		timer.Remove(round.timer)
		timer.Remove("RoundFinished")
	end	
	MsgC("INFO: ",Color(0,255,0), " Timers destroyed, round finished! \n")
	round.ongoing = false
end

function round.GetTotalTimeLeft()
	return timer.TimeLeft("RoundFinished")
end

function round.GetTickTimeLeft()
	return timer.TimeLeft(round.timer)
end

CM.Modules["Rounds"] = round
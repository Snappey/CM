local round = CM.Modules["Rounds"]


function round.StartRound()
	if round.ongoing then MsgC(Color(255,0,0) , "ERROR: ", Color(250,250,250), "Round already started, stop the current one before starting another!") return end

	timer.Create(round.timer, round.tick, round.tickTotal, round.Tick)
	timer.Create("RoundFinished", round.length, 1, round.Finished)
end

function round.Tick()
	hook.Call("RoundTick")
end

function round.Finished()
	hook.Call("RoundFinished")
	round.Stop()
end

function round.Stop()
	if timer.Exists(round.timer) || timer.Exists("RoundFinished") then
		timer.Destroy(round.timer)
		timer.Destroy("RoundFinished")
	end	
	MsgC("INFO: ",Color(0,255,0), " Timers destroyed, round finished!")
end

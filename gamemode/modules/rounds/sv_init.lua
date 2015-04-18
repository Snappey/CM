
local rounds = {}
rounds.enabled = true

rounds.length = (60 * 120) -- Seconds * Minutes
rounds.tickTotal = 12
rounds.tick = rounds.length / rounds.tickTotal -- Ticks 12 times throughout round
rounds.ongoing = false
rounds.timer = "roundsTick"

function rounds.Init()


end

function rounds.LoadModule()
	if rounds.enabled then
		CM.includeDir(CM.Modules.Dir .. "/rounds/cl", "", "init.lua")
		CM.includeDir(CM.Modules.Dir .. "/rounds/sv", CM.Modules.Dir .. "/rounds/sv", "init.lua")
	end
end

CM.AddModule("Rounds", rounds.LoadModule, rounds)

rounds.Init()
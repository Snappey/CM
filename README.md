# CM
Original CityMayhem Gamemode

# Hooks
CityMayhem gamemode exposes various hooks, the base gamemode exposes two main hooks currently. (Probably make more later)

## PreInit
```lua
hook.Add("PreInit", "Testing", function()
  print("Called before base gamemode is loaded!")
end)

```

## PostInit
```lua
hook.Add("PostInit", "Testing", function()
  print("Called after the base gamemode is loaded, and the module system.")
end)
```

# Modules

## Round System

### Summary
Rounds module handles the rounds in the gamemode. 
The module can be broken down into two timers, total time left and tick time left. Total time left handles the time untill the round finished, while Tick time handles the time untill next tick.

### Functions

Where round = CM.Modules["Rounds"]

#### round.StartRound()

Starts the round, if a round is ongoing it prevents a new one from starting.

```lua
round.StartRound()
```
No arguments, returns no values

#### round.Stop()

Stops the round provided there is one ongoing, it checks for any timers that are running and removes them.
Notifies you onces the timers are destroyed

```lua
round.Stop()
```
No arguments, returns no values

#### round.GetTotalTimeLeft()

Gets the time left in the main timer("RoundFinished"), uses timer.TimeLeft.

```lua
timeleft = round.GetTotalTimeLeft()
print("Time left: " .. timeleft)

Output: Time left: 7198
```
No arguments, returns time left

#### round.GetTickTimeLeft()

Gets the time left in the tick timer("roundsTick"), uses timer.TimeLeft.

```lua
timeleft = round.GetTickTimeLeft()
print("Time left: " .. timeleft)

Output: Time left: 598
```
No arguments, returns time left

### Hooks

#### Round Tick

Round Tick is called after each tick in a round. After a repetition of the tick timer.

```lua

TotalTick = 0
hook.Add("RoundTick", "AddPoints", function()
  TotalTick = TotalTick + 1
end)

```
No arguments, returns no values


#### Round Finished

Round Finished is called after the round has finished and the main timer has been completed

```lua

hook.Add("RoundFinished", "Finished", function()
  print("Round has finished!")
end)

```

In order to start the round again you have to call round.StartRound() again. This cannot be called in Round Finished hook, round.Stop is called immediately after this hook.

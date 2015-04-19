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

The module system allows us to easily manage features in the gamemode, each module is deisgned to work independently from each other keeping things organised.

Modules can be organised in anyway you feel. However they all have to feature an entry point which loads the rest of the module. Most modules are made of two core components which include: Entry point and Core.

Entry point: this is where the file is loaded and registered into the system, features any configuration options. It also needs to feature a function that loads the core functionallity of the module.

Core: This features the actual module functionallity. For example creating the timer for the round system.

By breaking the module down into these compoments it allows us to load modules we require and disable ones we dont. Modules can then be loaded on the fly when required. Allowing modules to be hotloaded in, while the server is running.

### Example

The Round system has the following file structure:

```
/sv/sv_init.lua
sv_init.lua
```

The entry point is the initial sv_init.lua, while the core is within the sv folder.

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

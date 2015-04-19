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

Round system module handles the rounds to be used in the gamemode. The module can be broken down into two timers, total time left and tick time left. Total time left uses the indentifer "RoundFinished" while Tick time uses "roundsTick". 

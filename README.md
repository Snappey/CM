# CM
Original CityMayhem Gamemode

# Hooks
CityMayhem gamemode exposes various hooks, the base gamemode exposes two main hooks.

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

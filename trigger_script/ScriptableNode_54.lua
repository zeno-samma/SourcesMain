
local player = params.player
PackageHandlers.sendServerHandler(player, "Add Effect Speed", {"SpeedEffect", "asset/GamePass/Position/Speed/SpeedEffect.effect", false, { x = 0, y = 0, z = 0 }, 0, { x = 2, y = 2, z = 2 }})
player:setProp("moveSpeed", 0.8)
local playerCfg = player:getValue("PlayerCfg")
playerCfg.MaxSpeed = 0.8
player:setValue("PlayerCfg", playerCfg)
PackageHandlers.sendServerHandler(player, "Money Updated", player:getValue("Money"))
print("Item Used")

local player = params.player
PackageHandlers.sendServerHandler(player, "Add Effect Atk", {"UpAtk", "asset/custom_effect/Atk.effect", false, { x = 0, y = 0, z = 0 }, 0,{ x = 1, y = 1, z = 1 }})
local atk = player:prop("damage")
player:setProp("damage", atk*2)
local playerCfg = player:getValue("PlayerCfg")
playerCfg.AtkDefault = playerCfg.AtkDefault*2
player:setValue("PlayerCfg", playerCfg)
print(Lib.pv(playerCfg))
PackageHandlers.sendServerHandler(player, "Money Updated", player:getValue("Money"))
print("Item Used")

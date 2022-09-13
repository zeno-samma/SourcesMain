
local player = params.player
PackageHandlers.sendServerHandler(player, "Add Effect Money", {"X2Money", "asset/custom_effect/Gold.effect", false, { x = 0, y = 0, z = 0 }, 0, { x = 1, y = 1, z = 1 }})
local playerCfg = player:getValue("PlayerCfg")
playerCfg.MoneyBuff = 2
player:setValue("PlayerCfg", playerCfg)
print("Item Used")

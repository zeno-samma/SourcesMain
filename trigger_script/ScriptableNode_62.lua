
local player = params.player
local playerCfg = player:getValue("PlayerCfg")
playerCfg.FiveEggsMode = true
player:setValue("PlayerCfg", playerCfg)
print("Item Used")

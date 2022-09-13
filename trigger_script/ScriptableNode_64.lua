
local player = params.player
local playerCfg = player:getValue("PlayerCfg")
playerCfg.MaxPet = playerCfg.MaxPet + 4
player:setValue("PlayerCfg", playerCfg)

print("Item Used")
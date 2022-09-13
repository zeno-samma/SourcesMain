
local player = params.player
local playerCfg = player:getValue("PlayerCfg")
playerCfg.MaxPet = playerCfg.MaxPet + 99999999
player:setValue("PlayerCfg", playerCfg)

print("Item Used")
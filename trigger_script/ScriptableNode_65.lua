
local player = params.player

local playerCfg = player:getValue("PlayerCfg")
local inventory = player:getValue("Inventory")
playerCfg.MaxSlot = playerCfg.MaxSlot + 25
player:setValue("PlayerCfg", playerCfg)
PackageHandlers.sendServerHandler(player, "Return Inventory Data", {inventory, playerCfg})
print(playerCfg.MaxSlot)
print("Item Used")
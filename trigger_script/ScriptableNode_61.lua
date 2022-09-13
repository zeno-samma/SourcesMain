local player = params.player
local playerCfg = player:getValue("PlayerCfg")
playerCfg.DamePetBuff = 2
player:setValue("PlayerCfg", playerCfg)

local invent = player:getValue("Inventory")
if invent ~= nil then
    for i = 1, #invent do
        invent[i].Atk = invent[i].Atk * playerCfg.DamePetBuff
    end
end
player:setValue("Inventory", invent)

print("Item Used")

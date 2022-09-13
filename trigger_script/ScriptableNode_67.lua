
local player = params.player

local playerCfg = player:getValue("PlayerCfg")
playerCfg.FreeTeleport = true
player:setValue("PlayerCfg", playerCfg)

local gateFeeDiamond = player:getValue("Gate Fee Diamond")
for key, value in pairs(gateFeeDiamond) do
  gateFeeDiamond[key] = 0
end
player:setValue("Gate Fee Diamond", gateFeeDiamond)

print("Item Used")
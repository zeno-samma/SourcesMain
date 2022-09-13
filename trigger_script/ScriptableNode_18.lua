local player = params.player
local playerCfg = player:getValue("PlayerCfg")
local money = player:getValue("Money")
local data = require "script_server.shopCfg"
local shop = "Shop2"
local shopData = data.ShopConfig[shop]
-- print("Money.....")
-- print(Lib.pv(money))
if money.Gold < 1000 then
    -- player:sendTip(2, "You need 1000 more gold", 40)
    return
end
PackageHandlers.sendServerHandler(player, "Open Egg Shop", shopData)

if playerCfg.FiveEggsMode then
  PackageHandlers.sendServerHandler(player, "Get 5 Eggs Mode")
end
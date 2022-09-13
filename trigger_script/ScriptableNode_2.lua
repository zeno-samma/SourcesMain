--You can use "params.parameter name" to get the parameters defined in the node. 					
--For example, if a parameter named "entity" is defined in the node, you can use "params.entity" to get the value of the parameter.

local player = params.clickPlayer
local playerCfg = player:getValue("PlayerCfg")
local money = player:getValue("Money")
local data = require "script_server.shopCfg"
local shop = params.this.name
local shopData = data.ShopConfig[shop]
-- print("Money.....")
-- print(Lib.pv(money))
-- print(Lib.pv(shopData.Price))
if money.Gold < 300 then
    -- player:sendTip(2, "You need 300 more gold", 40)
    return
end
PackageHandlers.sendServerHandler(player, "Open Egg Shop", shopData)

if playerCfg.FiveEggsMode then
  PackageHandlers.sendServerHandler(player, "Get 5 Eggs Mode")
end
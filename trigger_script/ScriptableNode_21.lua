--You can use "params.parameter name" to get the parameters defined in the node. 					
--For example, if a parameter named "entity" is defined in the node, you can use "params.entity" to get the value of the parameter.

local player = params.clickPlayer
local gateFee = player:getValue("Gate Fee")
local money = player:getValue("Money")
-- print(Lib.pv(gateFee))
if money.Gold < gateFee.Zone2 then
      player:sendTip(2, "You need 75000 more gold", 40)
    return
elseif gateFee.Zone2 == 0 then
  player:setMapPos("Zone2", Lib.v3(10.906,2,-7.613)) 
else
  PackageHandlers.sendServerHandler(player, "openShopUI_Gate", {"Zone1", "Zone2"})
end


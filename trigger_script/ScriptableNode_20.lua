--You can use "params.parameter name" to get the parameters defined in the node. 					
--For example, if a parameter named "entity" is defined in the node, you can use "params.entity" to get the value of the parameter.

local player = params.clickPlayer
local gateFee = player:getValue("Gate Fee")
if gateFee.map001 == 0 then
  player:setMapPos("map001", Lib.v3(10.906,2,-7.613)) 
else
  PackageHandlers.sendServerHandler(player, "openShopUI_Gate", {"Zone1", "map001"})
end


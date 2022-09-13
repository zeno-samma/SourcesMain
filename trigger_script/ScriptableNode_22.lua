local player = params.clickPlayer
local gateFee = player:getValue("Gate Fee")
if gateFee.Zone1 == 0 then
  player:setMapPos("Zone1", Lib.v3(10.906,2,-7.613)) 
else
  PackageHandlers.sendServerHandler(player, "openShopUI_Gate", {"Zone2", "Zone1"})
end


local player = params.clickPlayer
local gateFee = player:getValue("Gate Fee")
if gateFee.Zone2 == 0 then
      player:setMapPos("Zone2", Lib.v3(10.906,2,-7.613)) 
else
      PackageHandlers.sendServerHandler(player, "openShopUI_Gate", {"Zone3", "Zone2"})
end

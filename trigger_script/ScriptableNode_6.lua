local player = params.player
local firstLogin = player:getValue("FirstLogin")
local playerCfg = player:getValue("PlayerCfg")
local gateFee = player:getValue("Gate Fee")
if firstLogin.first == 2 then
    firstLogin.first = 3
    player:setValue("FirstLogin", firstLogin)
    player:setMapPos("Zone1", Lib.v3(10.906,2,-7.613))
elseif gateFee.Zone1 == 0 then
  player:setMapPos("Zone1", Lib.v3(10.906,2,-7.613))
end


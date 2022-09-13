local player = params.clickPlayer
local gateFee = player:getValue("Gate Fee")
-- print(Lib.pv(gateFee)) 
if gateFee.map001 == 0 then
--   print("Da tra tien")
  player:setMapPos("map001", Lib.v3(10.906,2,-7.613)) 
end


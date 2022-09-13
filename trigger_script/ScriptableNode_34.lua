--You can use "params.parameter name" to get the parameters defined in the node. 					
--For example, if a parameter named "entity" is defined in the node, you can use "params.entity" to get the value of the parameter.

local player = params.clickPlayer
local data = require "script_server.shopCfg"
local shop = params.this.name
local shopData = data.ShopConfig[shop]


PackageHandlers.sendServerHandler(player, "Open Egg Shop", shopData)

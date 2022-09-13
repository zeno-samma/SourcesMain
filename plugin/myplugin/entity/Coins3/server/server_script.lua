print("sandbox:hello word")
local lib2 = require "script_server.Lib2"
local canRevive = true
local coin = this

Trigger.RegisterHandler(this:cfg(), "ENTITY_DIE", function(context)
  -- print("Coin Died")
  -- print("canRevive: " .. tostring(canRevive))
  if canRevive then
    -- print("vao if")
    coin = context.obj1
    local PetBasic = context.obj2
    
    ------------------------------ Cộng tiền cho người chơi --------------------------------
    local player = PetBasic:owner()
    local chestConfig = require "script_server.chestCfg"
    local chestCfg = chestConfig.chestConfig
    
    local coinName = coin.name  -- myplugin/coins
    local money = player:getValue("Money")
    local playerCfg = player:getValue("PlayerCfg")	
    local buff = playerCfg.MoneyBuff
    local map = PetBasic.map
    local mapName = map.name
    if chestCfg[mapName][coinName] ~= nil then
      for key, value in pairs(chestCfg[mapName][coinName].Received) do
        money[key] = tonumber(money[key]) + value * buff
      end
    end
    player:setValue("Money", money)

    ------------------------------ Tạo NPC --------------------------------
    local spawnConfig = chestConfig.SpawnConfig[mapName]
		lib2.createNPCWithinTheRegion(
			spawnConfig.MinPos,
			spawnConfig.MaxPos,
			1,
			1,
			spawnConfig.CfgName,
			"",
			mapName,
			"",
			0
		)
    -- print("Entity Created In Map (coin): " .. mapName)
  end
end)

local name = {}

Trigger.RegisterHandler(this:cfg(), "ENTITY_ENTER", function(context)
    coin = context.obj1
    local map = coin.map
    local mapName = map.name
    local data = require "script_server.chestCfg"
    local chestConfig = data.chestConfig

    for key, value in pairs(chestConfig[mapName]) do
      table.insert(name, key)
    end
    local rand = math.random(1, #name)
    
    coin:changeActor(name[rand] .. ".actor")
    coin.name = name[rand]
    coin:setProp("maxHp", chestConfig[mapName][name[rand]].Hp) 
    coin:setHp(chestConfig[mapName][name[rand]].Hp)
    -- print(chestConfig[mapName][name[rand]].Hp)
    -- print("Coin Entered")
    -- print("canRevive: " .. tostring(canRevive))
end)


Lib.subscribeEvent("Can Revive Updated" .. coin.objID, function(_canRevive)
  canRevive = _canRevive
  --print("Triggered Can Revive Updated" .. coin.objID .. " To: " .. tostring(canRevive))
  -- print("canRevive: " .. tostring(canRevive))
end)

Lib.subscribeEvent("Kill Object" .. coin.objID, function()
  World.Timer(10, function()
    -- print("Kill")
    -- print("canRevive: " .. tostring(canRevive))
    canRevive = false
    coin:kill(coin, "")
  end)
end)


Trigger.RegisterHandler(this:cfg(), "ENTITY_TOUCH_ALL", function(context)
  local from = context.obj1
  local to = context.obj2
  if to.name == "Coins3" then
      -- print("Coin Touched")
      coin:kill(coin, "")
  end
end)
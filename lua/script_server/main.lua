print("script_server:hello world")
require "script_server.sevenLoginCtrl"
local petConfig =  require "script_server.PetCfg"
petConfig = petConfig.petConfig
local shopConfig = require "script_server.shopCfg"
shopConfig = shopConfig.ShopConfig
local lib2 = require "script_server.Lib2"
local chestConfig = require "script_server.chestCfg"
local luckyWheelConfig = require "script_server.LuckyWheelCfg"
for k, prizeType in pairs(luckyWheelConfig) do
	if( k ~= "Price" and k ~= "StagesPrize") then
		for key, value in pairs(prizeType) do
			value[1] = petConfig[value[1]]
		end
	end
end
for prizeType, prizeValue in pairs(luckyWheelConfig.StagesPrize) do
	for key, value in pairs(prizeValue) do
		luckyWheelConfig.StagesPrize[prizeType][key] = petConfig[value]
	end
end
print(Lib.pv(luckyWheelConfig.StagesPrize))
------------------------------------------                    VARIABLE                    ------------------------------------------

--[[
	petShowed = {
		player1 = {
			petData.Name (Dog) = {
				["1"] = {index1, index2, index3}
				["2"] = {level1, level2, level3}
			}
			Cat = {
				["1"] = {index4}
				["2"] = {level4}
			}
		}
	}
]]

local petShowed = {}
local tempArray = {}

local gamepassName = {
	"UpAtk",
	"SpeedBuff",
	"X2Money",
	"X2Damaged",
	"FiveEgg"
}

------------------------------------------                    FUNCTION                    ------------------------------------------
local function ReturnPet(player)
	local invent = player:getValue("Inventory")
	local PlayerCfg = player:getValue("PlayerCfg")
	for i = 1, #invent, 1 do
		local petData = invent[i]      --- lấy pet data từ inventory của player

		if (petShowed[player][petData.Name] ~= nil and petShowed[player][petData.Name] ~= {}) then
			for i = 1, #petShowed[player][petData.Name][1] do    --- Giết tất cả pet petData.Name đang hiện
				local pet = player:getPet(petShowed[player][petData.Name][1][i])
				pet:kill(pet,"") 

				------- SPECIAL CASE -------
				if(petData.Name == "Yasuo") then
					World.Timer(100, function()
						local playerCfg = player:getValue("PlayerCfg")
						player:setProp("moveSpeed", playerCfg.MaxSpeed / 1.5)
						playerCfg.MaxSpeed = playerCfg.MaxSpeed / 1.5
						player:setValue("PlayerCfg", playerCfg)
						print(Lib.pv(playerCfg))
					end)
				end
			end
			petShowed[player][petData.Name] = nil
		end
	end
	PackageHandlers.sendServerHandler(player, "Summoning", {0, PlayerCfg.MaxPet})
end
local function Claim7day(player)
	local firstLogin = player:getValue("FirstLogin")
	local money = player:getValue("Money")
	local nCount = firstLogin.Count
	if (nCount == 0) then --phần thưởng thứ 1
			player:addItem("myplugin/WoodenP", nCount+1, nil, "enter")
	elseif (nCount == 1) then --phần thưởng thứ 2
			money.Gold = tonumber(money.Gold) + 300
	elseif (nCount == 2) then
			money.Diamond = tonumber(money.Diamond) + 100
	elseif (nCount == 3) then --phần thưởng thứ 4
			money.Gold = tonumber(money.Gold) + 600
	elseif (nCount == 4) then --phần thưởng thứ 5
			money.Diamond = tonumber(money.Diamond) + 200
	elseif (nCount == 5) then --phần thưởng thứ 5
			money.Gold = tonumber(money.Gold) + 900
	elseif (nCount == 6) then --phần thưởng thứ 5
		Lib.emitEvent("Add Pet to Player", {player, petConfig.Yasuo, 1})
	end
	firstLogin.Count = nCount + 1
	player:setValue("FirstLogin", firstLogin)
	player:setValue("Money", money)
	if nCount > 6 then
		player:sendTip(2, "You have received enough rewards today", 40)
	end
	print("In gia tri sau khi nhan qua")
	print(Lib.pv(firstLogin))
end  
local function Addspeed(player,pack)
	local playerCfg = player:getValue("PlayerCfg")
	-- print("Thong bao Pack")
	-- print(pack)
	if pack == 0 then
		player:setProp("moveSpeed", 0)
		playerCfg.MaxSpeed = 0
	elseif pack == 1 then
		player:setProp("moveSpeed", 0.4)
		playerCfg.MaxSpeed = 0.4
	end
	player:setValue("PlayerCfg", playerCfg)
end
local function Countdown(player,timeLeft)
	local dayGift = player:getValue("DayGift")
	local i = 0
	World.Timer(0, function()
		if (i < timeLeft) then 
			i =  i + 10
			dayGift.Last = i
			player:setValue("DayGift", dayGift)
			player:sendTip(3,""..math.floor((timeLeft - i)/20).." seconds left to receive the reward", 40)
			return 10
		else
			i = 0
			dayGift.Flag = 1
			player:setValue("DayGift", dayGift)
			PackageHandlers.sendServerHandler(player, "Return ClaimAward",dayGift)	
		end
	end)
end

local function tele(player, gate)
	local zone = gate
    local map =  World.CurWorld:getMap(zone)
	print(zone)
    player:setMapPos(map, Lib.v3(10.906,2,-7.613)) 
	--player:setMap(map)
end



local function increaseMoney(player, moneyType, value)
	local money = player:getValue("Money")     -- get money

	if tonumber(money[moneyType]) + value < 0 then        -- check if money isn"t enough
		print("Khong du tien")
		return false
	end
	                                            -- increase money
	money[moneyType] = tonumber(money[moneyType]) + value
	player:setValue("Money", money)
	print("Increase Money: " .. money[moneyType])
	return true
end



local function setPetData(pet, petData)
	pet:changeActor(petData.Name .. ".actor")         -- Set Model pet
	pet.name = petData.Name	 						   -- Set tên pet
	pet:setProp("maxHp", petData.HP)      -- Set maxHP
    pet:setHp(petData.HP)				   -- Set HP
	pet:setProp("damage", petData.Atk)    -- Set ATK
	-- local control = pet:getAIControl()
	-- for key, value in pairs(petData.Skill) do
	-- 	control:addSkill(value)
	-- end
	print(petData.Atk)
end



local function sortInventory(player)
	local invent = player:getValue("Inventory")
	tempArray = {}
	local i = 1

	for i = 1, #invent do
		if (invent[i] ~= nil) then
			print(invent[i].Atk)
			tempArray[i] = invent[i].Atk
		end
	end


	for i = 1, #tempArray do
		for j = i, #tempArray do
			if (tempArray[i] < tempArray[j]) then
				local temp = tempArray[i]
				tempArray[i] = tempArray[j]
				tempArray[j] = temp

				temp = invent[i]
				invent[i] = invent[j]
				invent[j] = temp

				temp = invent[i].Slot
				invent[i].Slot = invent[j].Slot
				invent[j].Slot = temp
			end
		end
	end
	
	player:setValue("Inventory", invent)
end



local function addPetToInventory(player, petData, count)
	local invent = player:getValue("Inventory")   --- Lấy player inventory
	local playerCfg = player:getValue("PlayerCfg")
	local maxInventory = playerCfg.MaxSlot
	print(Lib.pv(petData))															 
	local name = petData.Name
	local level = petData.Level

	if (invent ~= nil)then --- check full slot
		local slotCount = 0
		for i = 1, #invent do
			slotCount = slotCount + invent[i].Count
		end
		if slotCount + count > maxInventory then
			print("Khong du slot")
			player:sendTip(2, "Inventory is full", 40)
			return
		end
	end

	for slot, value in pairs(invent) do        ---Lặp tất cả slot trong player inventory
		if(value.Name == name and value.Level == level) then          --- Nếu trùng tên và level thì cộng Count
			value.Count = value.Count + count
			player:setValue("Inventory", invent)
			print("Pet: " .. value.Name .. " Slot: " .. value.Slot .. " Count: " .. value.Count)
			return
		end
	end
                            --- Nếu không trùng thì thêm vào inventory
	local slot = #invent + 1
	local newNode = {
		Name = name,
		Label = petData.Label,
		Slot = slot,
		Level = petData.Level,
		Atk = petData.Atk,
    	HP = petData.HP,
		Skill = petData.Skill,
		Count = count
	}
	
	table.insert(invent, newNode)
	player:setValue("Inventory", invent)
	sortInventory(player)

	print("Pet: " .. newNode.Name .. " Slot: " .. newNode.Slot .. " Level: " .. newNode.Level .. " Count: " .. newNode.Count)
end



local function summonPet(player, slot, count)
	local invent = player:getValue("Inventory")
	local playerCfg = player:getValue("PlayerCfg")
	local petData = invent[slot]    --- lấy pet data từ inventory của player
	local level = petData.Level

	local i = 0      --- chứa số pet đang hiện
	local j = 0      --- chứa số pet đang hiện của level muốn summon
	if (petShowed[player] ~= nil and petShowed[player] ~= {}) then
		for key, value in pairs(petShowed[player]) do  --- Lấy số pet đang hiện
			if value[2] ~= nil then 
				for k = 1, #value[2] do
					i = i + 1
					if (key == petData.Name) and (value[2][k] == level) then   --- Lấy số pet đang hiện của level muốn summon
						j = j + 1
					end
				end
			end
		end
	end

	print("Dang hien: "..i)
	print("Dang hien cua level: "..j)
	if (i < playerCfg.MaxPet) then ---Nếu số pet đang hiện < 4
		print("Show Pet")
		
		if (petShowed[player][petData.Name] == nil) then
			petShowed[player][petData.Name] = {}
		end
		--- nếu số lượng pet loại này đang hiện + summonCount <= số pet trong inventory và số pet đang hiện + count <= 4
		if (j + count <= petData.Count) and (i + count <= playerCfg.MaxPet) then
			for i = 1, count do  --- hiện pet
				local index = player:createPet("myplugin/BasicPet", true, player.map, player:getPosition())
				if (petShowed[player][petData.Name][1] == nil) then
					petShowed[player][petData.Name][1] = {}
					petShowed[player][petData.Name][2] = {}
				end
				table.insert(petShowed[player][petData.Name][1], index)
				table.insert(petShowed[player][petData.Name][2], level)
				--print(Lib.pv(petShowed[player]))
				local pet = player:getPet(index)
				setPetData(pet, petData)

				-------- SPECIAL CASE -------
				if(petData.Name == "Yasuo") then
					World.Timer(100, function()
						local playerCfg = player:getValue("PlayerCfg")
						playerCfg.MaxSpeed = player:prop("moveSpeed")
						player:setProp("moveSpeed", playerCfg.MaxSpeed * 1.5)
						playerCfg.MaxSpeed = playerCfg.MaxSpeed * 1.5
						player:setValue("PlayerCfg", playerCfg)
						print(Lib.pv(playerCfg))
					end)
				end
			end
			-- print("ABCDXYZ"..i+count)
			PackageHandlers.sendServerHandler(player, "Summoning", {i+count, playerCfg.MaxPet})
			return
		end
	else
		print("Maximun Pet Showed")
	end
end



local function removePet(player, slot, count)
	local invent = player:getValue("Inventory")
	local PlayerCfg = player:getValue("PlayerCfg")
	local petData = invent[slot]      --- lấy pet data từ inventory của player

	if (petShowed[player][petData.Name] ~= nil) then
		local i = 0      --- chứa số pet đang hiện
		if (petShowed[player] ~= nil and petShowed[player] ~= {}) then
			for key, value in pairs(petShowed[player]) do  --- Lấy số pet đang hiện
				if value[2] ~= nil then 
					for k = 1, #value[2] do
						i = i + 1
					end
				end
			end
		end
		PackageHandlers.sendServerHandler(player, "Summoning", {i - #petShowed[player][petData.Name][1], PlayerCfg.MaxPet})
		for i = 1, #petShowed[player][petData.Name][1] do    --- Giết tất cả pet petData.Name đang hiện
			local pet = player:getPet(petShowed[player][petData.Name][1][i])
			pet:kill(pet,"") 

			------- SPECIAL CASE -------
			if(petData.Name == "Yasuo") then
				print("agrfdhssthtjdrjtrh")
				World.Timer(100, function()
					local playerCfg = player:getValue("PlayerCfg")
					player:setProp("moveSpeed", playerCfg.MaxSpeed / 1.5)
					playerCfg.MaxSpeed = playerCfg.MaxSpeed / 1.5
					player:setValue("PlayerCfg", playerCfg)
					print(Lib.pv(playerCfg))
				end)
			end
		end
		petShowed[player][petData.Name] = nil
	end


	if (petData.Count - count >= 0) then
		petData.Count = petData.Count - count
		if (petData.Count == 0) then
			for i = petData.Slot, #invent do
				if (i == #invent) then
					invent[i] = nil
				else
					invent[i] = invent[i + 1]
					invent[i].Slot = i
				end
			end
		end
		player:setValue("Inventory", invent)   --- cập nhật lại inventory
		sortInventory(player)
	end
end



local function rollLuckyWheel(rollType, rollCount)
	local result = {}
	for i = 1, rollCount do
		local rand = math.random(1, 100)
		for j = 1, 10 do
			if (rand <= luckyWheelConfig[rollType][j][2]) then
				table.insert(result, j)
				break
			else
				rand = rand - luckyWheelConfig[rollType][j][2]
			end
		end
	end
	print(Lib.pv(result))
	return result
end



------------------------------------------                    TRIGGER                    ------------------------------------------

Trigger.RegisterHandler(Entity.GetCfg("myplugin/player1"), "ENTITY_LEAVE", function(context)
    local player = context.obj1
	local firstLogin = player:getValue("FirstLogin")
	local dayGift = player:getValue("DayGift")
	local money = player:getValue("Money")
	local gateFee = player:getValue("Gate Fee")
	local gateFeeDiamond = player:getValue("Gate Fee Diamond")
	local inventory = player:getValue("Inventory")
	local playerCfg = player:getValue("PlayerCfg")
	dayGift.Flag = 0
	print(dayGift.Flag)
	print("firstLogin.first")
	print(firstLogin.first)

	-------------------Save data affter leave
	player:setValue("DayGift", dayGift)
	player:setValue("FirstLogin", firstLogin)
	player:setValue("Money", money)
	player:setValue("Gate Fee", gateFee)
	player:setValue("Gate Fee Diamond", gateFeeDiamond)
	player:setValue("Inventory", inventory)
	player:setValue("PlayerCfg", playerCfg)
	-------------------
	print("firstLogin:")
	print(Lib.pv(firstLogin))
	print("dayGift:")
	print(Lib.pv(dayGift))
	print("money:")
	print(Lib.pv(money))
	print("gateFee:")
	print(Lib.pv(gateFee))
	print("gateFeeDiamond:")
	print(Lib.pv(gateFeeDiamond))
	print("inventory:")
	print(Lib.pv(inventory))
	print("playerCfg:")
	print(Lib.pv(playerCfg))
end)
Trigger.addHandler(Entity.GetCfg("myplugin/player1"), "ENTITY_ENTER", function(context)
    local player = context.obj1
	local oldMoney = player:getValue("Money")
	local playerCfg = player:getValue("PlayerCfg")
	local dayGift = player:getValue("DayGift")
	local firstLogin = player:getValue("FirstLogin")
	local gateFee = player:getValue("Gate Fee")
	local gateFeeDiamond = player:getValue("Gate Fee Diamond")
	local inventory = player:getValue("Inventory")
	local hour = tonumber(os.date("%H"))
	local minute = tonumber(os.date("%M"))
	local second = tonumber(os.date("%S"))
	player:setProp("moveSpeed", playerCfg.MaxSpeed)
	player:setProp("damage", playerCfg.AtkDefault)
		if  playerCfg.CurSkin == nil or playerCfg.TotalWheel == nil  then
		playerCfg.SkinsInventory = {}
		playerCfg.CurSkin = {def = "def"}
		playerCfg.TotalWheel = {
			Diamond = {
				Value = 0,
				ClaimStages = 0
			},
			GCube = {
				Value = 0,
				ClaimStages = 0
			}
		}
	end
--------------in data khi nguoi choi vao game
print("firstLogin:")
print(Lib.pv(firstLogin))
print("dayGift:")
print(Lib.pv(dayGift))
print("money:")
print(Lib.pv(oldMoney))
print("gateFee:")
print(Lib.pv(gateFee))
print("gateFeeDiamond:")
print(Lib.pv(gateFeeDiamond))
print("inventory:")
print(Lib.pv(inventory))
print("playerCfg:")
print(Lib.pv(playerCfg))
--------------
	if firstLogin.first < 8 and firstLogin.first > 0 then
		firstLogin.first = 1
		player:setValue("FirstLogin", firstLogin)
		PackageHandlers.sendServerHandler(player, "OpenStep1",firstLogin)
		print("Quay lai tutorial")
	elseif 	firstLogin.first >= 8 then
		Addspeed(player,1)
		World.Timer(250, function()
			PackageHandlers.sendServerHandler(player,"openUI", oldMoney)
			PackageHandlers.sendServerHandler(player,"openUIPet")
			PackageHandlers.sendServerHandler(player,"OnlineUi")
			PackageHandlers.sendServerHandler(player,"LoadingUi")
			PackageHandlers.sendServerHandler(player,"DayGift Updated",dayGift)
		end)

	end
	-- print("dayGift.Flag= "..dayGift.Flag)
	-- print("dayGift.Last= "..dayGift.Last)
	-- print("dayGift.Last = "..(math.floor(dayGift.Last/20)))
	local dayEndTime = (24 - hour - 1) * 60 * 60 * 20 + (60 - minute - 1) * 60 * 20 + (60 - second) * 20
	print("Day End: " .. dayEndTime)
	if (dayGift.Day < dayEndTime) then
		dayGift.Day = dayEndTime
		dayGift.Count = 0
		player:setValue("DayGift", dayGift)
	end
	if dayGift.Count >= 0 and dayGift.Count < 5 then
		print(dayGift.Flag)
		World.Timer(1*20, function()
			if dayGift.Flag == 0 then --Chưa nhận quà
			print("Flag == 0")
				Countdown(player,dayGift.Relay_Time - dayGift.Last)
			end
		end)
	end
	if (playerCfg.MaxSpeed == 0.8) then
		PackageHandlers.sendServerHandler(
			player,
			"Add Effect Speed",
			{
				"SpeedEffect",
				"asset/GamePass/Position/Speed/SpeedEffect.effect",
				false,
				{ x = 0, y = 0, z = 0 },
				0,
				{ x = 2, y = 2, z = 2 }
			})
	end	
	if (playerCfg.MoneyBuff == 2) then
		PackageHandlers.sendServerHandler(
			player,
			"Add Effect Money",
			{
				"X2Money",
				"asset/custom_effect/Gold.effect",
				false,
				{ x = 0, y = 0, z = 0 },
				0,
				{ x = 1, y = 1, z = 1 }
			})
	end	
	if (playerCfg.AtkDefault >= 2) then
		PackageHandlers.sendServerHandler(
			player,
			"Add Effect Atk",
			{
				"UpAtk",
				"asset/custom_effect/Atk.effect",
				false,
				{ x = 0, y = 0, z = 0 },
				0,
				{ x = 1, y = 1, z = 1 }
			})
	end
	-- if (playerCfg.Tutorial == 2) then
	-- 	PackageHandlers.sendServerHandler(player, "Return Tutorial")
	-- end
	playerCfg = player:getValue("PlayerCfg")
	player:setValue("PlayerCfg", playerCfg)
	print("PlayerCfg Updated")
	PackageHandlers.sendServerHandler(player, "PlayerCfg Updated", playerCfg)
	player:setValue("PlayerCfg", playerCfg)
	player:setValue("Money", oldMoney)
	player:setValue("FirstLogin", firstLogin)
	-- print(Lib.pv(dayGift))
end)



Trigger.addHandler(Entity.GetCfg("myplugin/player1"), "ENTER_MAP", function(context)
	local player = context.obj1
	local map = context.map
	local mapName = map.name
	local money = player:getValue("Money")
	local firstLogin = player:getValue("FirstLogin")
	local PlayerCfg = player:getValue("PlayerCfg")
	local hadPlayer = false     -- kiểm tra xem map đã có ai trước đó chưa
	petShowed[player] = {}
	print(mapName)
	


	for id, plr in pairs(map.players) do  -- duyệt qua tất cả người chơi ở trong map hiện tại
		if(plr.name ~= player.name) then
			hadPlayer = true
			print("Had Player In The Map: " .. mapName)
		end
	end

	if (hadPlayer == false) then     -- nếu chưa có ai ở map trước đó
		local spawnConfig = chestConfig.SpawnConfig[mapName]
		if spawnConfig then
			lib2.createNPCWithinTheRegion(
			spawnConfig.MinPos,
			spawnConfig.MaxPos,
			spawnConfig.MinCount,
			spawnConfig.MaxCount,
			spawnConfig.CfgName,
			"",
			mapName,
			"",
			0
		)
		end
		print("Entity Created In Map: " .. mapName)
	end
	PackageHandlers.sendServerHandlerToAll("showOrCloseGuide",{})
	PackageHandlers.sendServerHandler(player,"LoadingUi")
	if firstLogin.first == 3 then
		firstLogin.first = 4
		Addspeed(player,0)
		print("Bước 3")
		print("firstLogin.first")
		print(firstLogin.first)
		player:setValue("FirstLogin", firstLogin)
		PackageHandlers.sendServerHandler(player,"Step5", firstLogin)-->chuyển tới bước 5-->open ui  hướng dẫn TutorialStep3
	end
	ReturnPet(player)
end)



Trigger.addHandler(Entity.GetCfg("myplugin/player1"), "LEAVE_MAP", function(context)
	local player = context.obj1
	local map = context.map
	local mapName = map.name
	local hadOtherPlayer = false    -- kiểm tra xem map còn người chơi khác ở lại không
	petShowed[player] = nil
	local spawnConfig = chestConfig.SpawnConfig[mapName]
	print("Player leave map: " .. mapName)

	for id, plr in pairs(map.players) do  -- duyệt qua tất cả người chơi ở trong map hiện tại
		if(plr.name ~= player.name) then
			hadOtherPlayer = true
			print("Having other player in map: " .. mapName)
		end
	end

	if (hadOtherPlayer == false) then
		for id, object in pairs(map.objects) do
			if object and object:isValid() and not object.isPlayer and spawnConfig ~= nil then
				-- print(object:cfg().fullName)
				if (object:cfg().fullName == spawnConfig.CfgName) then
					Lib.emitEvent("Can Revive Updated" .. object.objID, false)
					Lib.emitEvent("Kill Object" .. object.objID)
					-- print("Killed: " .. object.name)
				end
			end
		end
	end
end)
Trigger.RegisterHandler(Entity.GetCfg("myplugin/player1"), "HAND_ITEM_CHANGED", function(context)
	local player = context.obj1                                            
	local newItem = context.item
	local oldItem = context.oldItem
	local firstLogin = player:getValue("FirstLogin")
	local playerCfg = player:getValue("PlayerCfg")
	local atk = player:prop("damage")
	local AtkDefault = playerCfg.AtkDefault
	print(firstLogin.first)
	print("HAND_ITEM_CHANGED")
	for index, passName in ipairs(gamepassName) do
		if newItem ~= nil then
			if newItem:full_name() == "myplugin/" .. passName then
					PackageHandlers.sendServerHandler(player, "Show Notify", {
						Header = "Tips",
						Content =  "Handing item " .. passName .. " and holding click on your character to use ."
					})
			end
		else
			player:sendTip(2, "...", 40)
		end
	end 
	if firstLogin.first == 4 then
		if newItem ~= nil then
			-- PackageHandlers.sendServerHandler(player,"CheckItem", newItem:full_name())---sau khi cầm cuốc trên tay chuyển tới bước 6
			-- PackageHandlers.sendServerHandler(player,"CheckItem")---sau khi cầm cuốc trên tay chuyển tới bước 6
  			print(newItem:full_name())
			  
  			if newItem:full_name() == "myplugin/WoodenP" then
				print("Vao debug vao day")
				-- print(newItem:full_name())
				PackageHandlers.sendServerHandler(player,"StepCuoc", firstLogin)---sau khi cầm cuốc trên tay chuyển tới bước 6
 			end
		else
			player:sendTip(2, "You need to hold a pickaxe", 40)
		end
	end 
	if newItem ~= nil then
		  print(newItem:full_name())
		if newItem:full_name() == "myplugin/WoodenP" then
			-- print(newItem:full_name())
			player:setProp("damage", AtkDefault + 1)
		elseif  newItem:full_name() == "myplugin/StoneP" then
			player:setProp("damage", AtkDefault + 2)
		elseif  newItem:full_name() == "myplugin/IronP" then
			player:setProp("damage", AtkDefault + 4)
		elseif  newItem:full_name() == "myplugin/GoldP" then
			player:setProp("damage", AtkDefault + 8)
		elseif  newItem:full_name() == "myplugin/DiamondP" then
			player:setProp("damage", AtkDefault + 16)
		else
			player:setProp("damage", AtkDefault)
		end
	else
		player:setProp("damage", AtkDefault)
		player:sendTip(2, "You need to hold a pickaxe", 40)
	end
	player:setValue("PlayerCfg", playerCfg)
	PackageHandlers.sendServerHandler(player, "Money Updated", player:getValue("Money"))  
end)


PackageHandlers.registerServerHandler("Check7day", function(player)
	local firstLogin = player:getValue("FirstLogin")
	local hour = tonumber(os.date("%H"))
	local minute = tonumber(os.date("%M"))
	local second = tonumber(os.date("%S"))
	local dayEndTime = (24 - hour - 1) * 60 * 60 * 20 + (60 - minute - 1) * 60 * 20 + (60 - second) * 20
	if firstLogin.Day < dayEndTime  then
		firstLogin.Day = dayEndTime
		player:setValue("FirstLogin", firstLogin)
		print("Add dayendtime")
		print(Lib.pv(firstLogin))
		Claim7day(player)
	end
end)	
PackageHandlers.registerServerHandler("ClaimAward", function(player)
		local dayGift = player:getValue("DayGift")
		local money = player:getValue("Money")
		local nCount = dayGift.Count
		if (nCount == 0) then --phần thưởng thứ 1
			-- player:addItem("myplugin/Coins", nCount+1, nil, "enter")
				money.Gold = tonumber(money.Gold) + 300
		elseif (nCount == 1) then --phần thưởng thứ 2
			-- player:addItem("myplugin/DiamondCoin", nCount+1, nil, "enter")
				money.Diamond = tonumber(money.Diamond) + 200
		elseif (nCount == 2) then
			-- player:addItem("myplugin/Coins", nCount+1, nil, "enter")
				money.Gold = tonumber(money.Gold) + 300
		elseif (nCount == 3) then --phần thưởng thứ 4
			-- player:addItem("myplugin/DiamondCoin", nCount+1, nil, "enter")
				money.Diamond = tonumber(money.Diamond) + 400
		elseif (nCount == 4) then --phần thưởng thứ 5
			-- player:addItem("myplugin/Coins", nCount+1, nil, "enter")
				money.Gold = tonumber(money.Gold) + 500
		end
		dayGift.Last = 0
		dayGift.Count = nCount + 1
		player:setValue("DayGift", dayGift)
		player:setValue("Money", money)
		if nCount < 4 then
			Countdown(player,dayGift.Relay_Time)
		end
		-- print(Lib.pv(dayGift))
end)
PackageHandlers.registerServerHandler("End tutorial", function(player)
	local firstLogin = player:getValue("FirstLogin")
	local playerCfg = player:getValue("PlayerCfg")
		if firstLogin.first == 7 then
			firstLogin.first = 8
			Addspeed(player,1)
			print("Bước 7")
			print("firstLogin.first")
			print(Lib.pv(firstLogin))
			player:setValue("FirstLogin", firstLogin)
			player:setValue("PlayerCfg", playerCfg)
			print(Lib.pv(firstLogin))
		end
end)
PackageHandlers.registerServerHandler("Step11", function(player)
	local firstLogin = player:getValue("FirstLogin")
	if firstLogin.first == 6 then
		firstLogin.first = 7
		print("Bước 6")
		print("firstLogin.first")
		print(firstLogin.first)
		player:setValue("FirstLogin", firstLogin)
		PackageHandlers.sendServerHandler(player,"Step12", firstLogin)--->Tắt ui arrow client.
	end
end)
PackageHandlers.registerServerHandler("Step8", function(player)
	local firstLogin = player:getValue("FirstLogin")
	local portalPos = Lib.v3(18.423, 0.891,-63.792)
	if firstLogin.first == 5 then
		firstLogin.first = 6
		print("Bước 5")
		print("firstLogin.first")
		print(firstLogin.first)
		player:setValue("FirstLogin", firstLogin)
		Addspeed(player,0)
		player:setMapPos("Zone1", Lib.v3(16.7,2,-63.792))
	end
end)


PackageHandlers.registerServerHandler("Addspeed", function(player)
	Addspeed(player,1)
end)

PackageHandlers.registerServerHandler("Step6", function(player)
	local firstLogin = player:getValue("FirstLogin")
	if firstLogin.first == 4 then
		firstLogin.first = 5
		print("Bước 4")
		print("firstLogin.first")
		print(firstLogin.first)
		player:setValue("FirstLogin", firstLogin)
		PackageHandlers.sendServerHandler(player,"Step7", firstLogin)--->Buoc 8 open ui TutorialStep5
	end
end)

PackageHandlers.registerServerHandler("Step2", function(player)
	local firstLogin = player:getValue("FirstLogin")
	local playerCfg = player:getValue("PlayerCfg")
	local oldMoney = player:getValue("Money")
	local portalPos = Lib.v3(11.443, 2, 45.257)
	if firstLogin.first == 1 then
		firstLogin.first = 2
		Addspeed(player,1)
		print("Bước 2")
		print("firstLogin.first")
		print(firstLogin.first)
		player:setValue("FirstLogin", firstLogin)
		PackageHandlers.sendServerHandler(player,"showOrCloseGuide", { guidePos = portalPos })--->Open Ui TutorialStep2.
		PackageHandlers.sendServerHandler(player,"openUI", oldMoney)	
	end
end)
PackageHandlers.registerServerHandler("Step1", function(player)
		local firstLogin = player:getValue("FirstLogin")
		if firstLogin.first == 0 then
			firstLogin.first = 1
			print("Bước 1")
			print("firstLogin.first")
			print(firstLogin.first)
			player:setValue("FirstLogin", firstLogin)	
			PackageHandlers.sendServerHandler(player, "OpenStep1",firstLogin)
		end
end)

PackageHandlers.registerServerHandler("Kill Button Clicked", function(player)
	local map = player.map
	local mapName = map.name
	local hadOtherPlayer = false

	local spawnConfig = chestConfig.SpawnConfig[mapName]
	print("Player leave map: " .. mapName)

	for id, plr in pairs(map.players) do  -- duyệt qua tất cả người chơi ở trong map hiện tại
		if(plr.name ~= player.name) then
			hadOtherPlayer = true
			print("Having other player in map: " .. mapName)
		end
	end

	if (hadOtherPlayer == false) then
		for id, object in pairs(map.objects) do
			if object and object:isValid() and not object.isPlayer and spawnConfig ~= nil then
				print(object:cfg().fullName)
				if (object:cfg().fullName == spawnConfig.CfgName) then
					Lib.emitEvent("Can Revive Updated" .. object.objID, false)
					Lib.emitEvent("Kill Object" .. object.objID)
					print("Killed: " .. object.name)
				end
			end
		end
	end
end)

PackageHandlers.registerServerHandler("Get Gate Fee", function(player, pack)
	local curGate = pack[1]   -- cổng hiện tại
	local nextGate = pack[2]   -- cổng tiếp theo
	local fee = player:getValue("Gate Fee")[nextGate]
	
	PackageHandlers.sendServerHandler(player, "Return Gate Fee", {nextGate, fee})
end)



PackageHandlers.registerServerHandler("Tele", function(player, pack)
	local moneyType = pack[1]
	local gate = pack[2]
	print("Tele to gate "..gate)

	if moneyType == "Gold" then
		print("Gold")
		local gateFee = player:getValue("Gate Fee")
		local fee = gateFee[gate]

		local result = increaseMoney(player, "Gold", -fee)
		if result == false then
			-- PackageHandlers.sendServerHandler(player, "Not Enough Money")
			player:sendTip(2, "Not Enough Money", 40)
			return
		end
		
		gateFee[gate] = 0
		player:setValue("Gate Fee", gateFee)

	elseif moneyType == "Diamond" then
		print("Diamond")
		local gateFeeDiamond = player:getValue("Gate Fee Diamond")
		local fee = gateFeeDiamond[gate]

		local result = increaseMoney(player, "Diamond", -fee)
		if result == false then
			-- PackageHandlers.sendServerHandler(player, "Not Enough Money")
			player:sendTip(2, "Not Enough Money", 40)
			return
		end
		
		gateFeeDiamond[gate] = 0
		player:setValue("Gate Fee Diamond", gateFeeDiamond)
	else
		print("Bất lực")
	end

	tele(player, gate)
end)



PackageHandlers.registerServerHandler("Buy Egg", function(player, pack)
	local shopData = shopConfig[pack[1].EntityName]
	local fiveEggsMode = pack[2] and player:getValue("PlayerCfg").FiveEggsMode
	local eggsCount = 1
	local playerCfg = player:getValue("PlayerCfg")
	local invent = player:getValue("Inventory")
	local maxInventory = playerCfg.MaxSlot
	print(shopData.Name)


	local price = shopData.Price
	if fiveEggsMode then
		eggsCount = 5
		price = price * 5
	end

	if (invent ~= nil)then --- check full slot
		local slotCount = 0
		for i = 1, #invent do
			slotCount = slotCount + invent[i].Count
		end
		if slotCount + eggsCount > maxInventory then
			print("Khong du slot")
			player:sendTip(2, "Inventory is full", 40)
			return
		end
	end

	local result = increaseMoney(player, "Gold", -price)
	if result == false then
		-- PackageHandlers.sendServerHandler(player, "Not Enough Money")
		player:sendTip(2, "Not Enough Money", 40)
		return
	end

	local petData = {}
	for i = 1, eggsCount do
		local rand = math.random(1, 100000) -- 0.001%
		local petList = shopData.PetList
		local sum = 0
		local petName = ""

		for j = 1, #petList do
			if rand > sum + petList[j][2] * 1000 then
				sum = sum + petList[j][2] * 1000
			else
				petName = petList[j][1]
				print(petName)
				break
			end
		end
		petData[i] = petConfig[petName]
		petData[i].Atk = petData[i].Atk * playerCfg.DamePetBuff
		addPetToInventory(player, petData[i], 1)
	end
	-- print("Debug")
	-- print(Lib.pv(petData))
	PackageHandlers.sendServerHandler(player, "Pet Received", {petData, fiveEggsMode})
end)



PackageHandlers.registerServerHandler("Get Gate Fee Diamond", function(player, gate)
	local fee = player:getValue("Gate Fee Diamond")[gate]
	PackageHandlers.sendServerHandler(player, "Return Gate Fee Diamond", {gate, fee})
end)



PackageHandlers.registerServerHandler("Summon Pet", function(player, pack)
	local slot = pack[1]
	local count = pack[2]
	summonPet(player, slot, count)
end)



PackageHandlers.registerServerHandler("Quick Summon Pets", function(player)
	local tempInvent = player:getValue("Inventory")
	local totalCount = 0
	local maxCount = player:getValue("PlayerCfg").MaxPet
	local playerCfg = player:getValue("PlayerCfg")
	if tempInvent ~= nil then
		for i = 1, #tempInvent, 1 do                 --- lặp từ đầu tới cuối inventory
			--- nếu tổng số lượng pet hiện tại + số lượng pet đang được summon lớn hơn số lượng pet tối đa
			if tempInvent[i].Count + totalCount > maxCount then  
				--- summon pet từ slot i với số lượng là maxCount - totalCount
				summonPet(player, i, maxCount - totalCount)	
				break	
			else
				--- summon pet từ slot i với số lượng là tempInvent[i].Count
				summonPet(player, i, tempInvent[i].Count)
				totalCount = totalCount + tempInvent[i].Count
				-- if tempInvent[i].Name == "Yasuo" then
				-- 	player:setProp("moveSpeed", playerCfg.MaxSpeed * 1.5)
				-- 	playerCfg.MaxSpeed = playerCfg.MaxSpeed * 1.5
				-- 	player:setValue("PlayerCfg", playerCfg)
				-- -- else tempInvent[i].Name ~= "Yasuo" then
					
				-- end
			end
		end
	end
end)



PackageHandlers.registerServerHandler("Return Pet", function(player, slot)
	local invent = player:getValue("Inventory")
	local PlayerCfg = player:getValue("PlayerCfg")
	local petData = invent[slot]      --- lấy pet data từ inventory của player

	if (petShowed[player][petData.Name] ~= nil and petShowed[player][petData.Name] ~= {}) then
		local i = 0      --- chứa số pet đang hiện
		if (petShowed[player] ~= nil and petShowed[player] ~= {}) then
			for key, value in pairs(petShowed[player]) do  --- Lấy số pet đang hiện
				if value[2] ~= nil then 
					for k = 1, #value[2] do
						i = i + 1
					end
				end
			end
		end
		PackageHandlers.sendServerHandler(player, "Summoning", {i - #petShowed[player][petData.Name][1], PlayerCfg.MaxPet})
		for i = 1, #petShowed[player][petData.Name][1] do    --- Giết tất cả pet petData.Name đang hiện
			local pet = player:getPet(petShowed[player][petData.Name][1][i])
			pet:kill(pet,"") 

			------- SPECIAL CASE -------
			if(petData.Name == "Yasuo") then
				World.Timer(100, function()
					local playerCfg = player:getValue("PlayerCfg")
					player:setProp("moveSpeed", playerCfg.MaxSpeed / 1.5)
					playerCfg.MaxSpeed = playerCfg.MaxSpeed / 1.5
					player:setValue("PlayerCfg", playerCfg)
					print(Lib.pv(playerCfg))
				end)
			end
		end
		petShowed[player][petData.Name] = nil
	end
end)



PackageHandlers.registerServerHandler("Return All Pets", function(player)
	local invent = player:getValue("Inventory")
	local PlayerCfg = player:getValue("PlayerCfg")
	for i = 1, #invent, 1 do
		local petData = invent[i]      --- lấy pet data từ inventory của player

		if (petShowed[player][petData.Name] ~= nil and petShowed[player][petData.Name] ~= {}) then
			for i = 1, #petShowed[player][petData.Name][1] do    --- Giết tất cả pet petData.Name đang hiện
				local pet = player:getPet(petShowed[player][petData.Name][1][i])
				pet:kill(pet,"") 

				------- SPECIAL CASE -------
				if(petData.Name == "Yasuo") then
					World.Timer(100, function()
						local playerCfg = player:getValue("PlayerCfg")
						player:setProp("moveSpeed", playerCfg.MaxSpeed / 1.5)
						playerCfg.MaxSpeed = playerCfg.MaxSpeed / 1.5
						player:setValue("PlayerCfg", playerCfg)
						print(Lib.pv(playerCfg))
					end)
				end
			end
			petShowed[player][petData.Name] = nil
		end
	end
	PackageHandlers.sendServerHandler(player, "Summoning", {0, PlayerCfg.MaxPet})
end)


PackageHandlers.registerServerHandler("Remove Pet", function(player, pack)
	local slot = pack[1]
	local count = pack[2]
	removePet(player, slot, count)
end)



PackageHandlers.registerServerHandler("Upgrade Pet", function (player, slot)
	print(slot)
	local invent = player:getValue("Inventory")
	local petData = invent[slot]      --- lấy pet data từ inventory của player
	if (petData.Count > 1) then
		removePet(player, slot, 2)
		petData.Level = petData.Level + 1
		petData.Atk = math.floor(petData.Atk * 2 * 10) / 10
		petData.HP = math.floor(petData.HP * 2 * 10) / 10
		addPetToInventory(player, petData, 1)
	end
end)


-- PackageHandlers.registerServerHandler("Exchange Currency Gold", function(player, count)
--     local entityTrays = player:tray()
-- 	local item = entityTrays:find_item("myplugin/Coins") 
-- 	if item then
-- 		local curCount = item:stack_count()
-- 		if (curCount >= count) then
-- 			local money = player:getValue("Money")
-- 			item:consume(count)
-- 			money.Gold = tonumber(money.Gold) + count*300
-- 			player:setValue("Money", money)
-- 		end
-- 	end
-- end)

-- PackageHandlers.registerServerHandler("Exchange Currency Diamond", function(player, count)
-- 	local money = player:getValue("Money")

-- 	if money.Diamond >= (count*1000) then
-- 		money.Diamond = tonumber(money.Diamond) - count*1000
-- 		player:setValue("Money", money)
-- 		-- player:addItem("myplugin/DiamondCoin", count)
-- 		-- money.Diamond = tonumber(money.Diamond) + 1000
-- 	end
	
-- end)


PackageHandlers.registerServerHandler("Set Tutorial", function(player)
	local playerCfg = player:getValue("PlayerCfg")
	playerCfg.Tutorial = 2
	player:setValue("PlayerCfg", playerCfg)
	print("playerCfg.Tutorial = "..playerCfg.Tutorial)
end)


Lib.subscribeEvent("Add Pet to Player", function(pack)
	local player = pack[1]
	local petData = pack[2]
	local count = pack[3]
	addPetToInventory(player, petData, count)
end)


PackageHandlers.registerServerHandler("Get Lucky Wheel Info", function(player)
	local playerCfg = player:getValue("PlayerCfg")
	PackageHandlers.sendServerHandler(player, "Return Lucky Wheel Info", {luckyWheelConfig, playerCfg.TotalWheel})
	print(Lib.pv(playerCfg.TotalWheel))
end)

PackageHandlers.registerServerHandler("Roll Lucky Wheel", function(player, pack)
	local rollType = pack[1]
	local rollCount = pack[2]
	local playerCfg = player:getValue("PlayerCfg")

	local money = player:getValue("Money")
	if (rollType == "Diamond") then
		local result = increaseMoney(player, "Diamond", -rollCount * luckyWheelConfig.Price.Diamond)
		print(luckyWheelConfig.Price.Diamond)
		if result == false then
			-- PackageHandlers.sendServerHandler(player, "Not Enough Money")
			player:sendTip(2, "Not Enough Money", 40)
			return
		else
			local result = rollLuckyWheel(rollType, rollCount)
			PackageHandlers.sendServerHandler(player, "Return Lucky Wheel Result", result)
			playerCfg.TotalWheel[rollType].Value = playerCfg.TotalWheel[rollType].Value + rollCount
			player:setValue("PlayerCfg", playerCfg)
			print(Lib.pv(playerCfg.TotalWheel))
			for i = 1, rollCount do
				local petData = luckyWheelConfig[rollType][result[i]][1]
				addPetToInventory(player, petData, 1)
			end
		end
		print("Diamond Roll" .. rollType .. " " .. rollCount)
	elseif (rollType == "GCube") then
		local PayHelper = Game.GetService("PayHelper")
		PayHelper:payMoney(player, 1, rollCount * luckyWheelConfig.Price.GCube, function(ret)
			if ret then
				local result = rollLuckyWheel(rollType, rollCount)
				PackageHandlers.sendServerHandler(player, "Return Lucky Wheel Result", result)
				playerCfg.TotalWheel[rollType].Value = playerCfg.TotalWheel[rollType].Value + rollCount
				player:setValue("PlayerCfg", playerCfg)
				print(Lib.pv(playerCfg.TotalWheel))
				for i = 1, rollCount do
					local petData = luckyWheelConfig[rollType][result[i]][1]
					addPetToInventory(player, petData, 1)
				end
			end
		end)
		print("GCube Roll " .. rollType .. " " .. rollCount)
	end
end)
PackageHandlers.registerServerHandler("Claim Lucky Wheel", function(player, type)
	local playerCfg = player:getValue("PlayerCfg")
	local prizeResult = {}
	-- số vòng đã quay/10 - số stages đã nhận
	local prizeCount = math.floor(playerCfg.TotalWheel[type].Value/10)
	for i = playerCfg.TotalWheel[type].ClaimStages, prizeCount - 1, 1 do
		print("Claiming " .. tostring((i+1)*10) .. prizeCount)
		table.insert(prizeResult, luckyWheelConfig.StagesPrize[type][tostring((i+1)*10)])
		print(luckyWheelConfig.StagesPrize[type][tostring((i+1)*10)])
		addPetToInventory(player, luckyWheelConfig.StagesPrize[type][tostring((i+1)*10)], 1)
	end
	if prizeCount > playerCfg.TotalWheel[type].ClaimStages then
		print(Lib.pv(playerCfg.TotalWheel))
		print(Lib.pv(prizeResult))
		PackageHandlers.sendServerHandler(player, "Pet Received", {prizeResult, false, false})
	end
	playerCfg.TotalWheel[type].ClaimStages = prizeCount
	player:setValue("PlayerCfg", playerCfg)
end)	
PackageHandlers.registerServerHandler("Send Tip", function(player, tip)
	player:sendTip(2, tip, 40)
end)
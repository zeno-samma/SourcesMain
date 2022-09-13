print("startup ui")
---------------------------------- ClassUI ----------------------------------
local ClassUI = self:child("ClassUI")
local SpeedImageUI = ClassUI:child("SpeedImage")
local AtkImageUI = ClassUI:child("AtkImage")
local MoneyImageUI = ClassUI:child("MoneyImage")
---------------------------------- LefUI ----------------------------------
local LefUI = self:child("LefUI")
local LefTeleButton = LefUI:child("TeleButton")
local lefInventoryButton = LefUI:child("InventoryButton")
local lefLuckyWheelButton = LefUI:child("LuckyWheelButton")
-- local lefUpgradePickAxeButton = LefUI:child("UpgradePickAxeButton")
local lefSkinShopButton = LefUI:child("SkinsShopButton")														
local Summoning = LefUI:child("Summoning")														
---------------------------------- TeleUI ----------------------------------
local TeleUI = self:child("TeleUI")
local teleCloseButton = TeleUI:child("CloseButton")
local shop = TeleUI:child("map001")
local zone1 = TeleUI:child("Zone1")
local zone2 = TeleUI:child("Zone2")
local zone3 = TeleUI:child("Zone3")

---------------------------------- InventoryUI ----------------------------------
local InventoryUI = self:child("InventoryUI")
local inventCloseButton = InventoryUI:child("CloseButton")
local slotList = {}
local inventGridView = InventoryUI:child("GridView")
local inventSlotImg = InventoryUI:child("Slot1")
local bg = InventoryUI:child("bg")
local clickTutorial = InventoryUI:child("clickTutorial")
local EffectWindowPoint1 = InventoryUI:child("EffectWindowPoint1")
local inventSlotButton = InventoryUI:child("SlotBtn1")
local inventSlotCount = InventoryUI:child("Count1")
local inventSlotLevel = InventoryUI:child("Level1")
local inventQuickSummonButton = InventoryUI:child("QuickSummonButton")
local inventReturnAllPetButton = InventoryUI:child("ReturnAllPetButton")
local inventInventoryCount = InventoryUI:child("InventoryCount")
local inventory, playerCfg
----------------------------------- InfoPetUI -----------------------------------
local InfoPetUI = self:child("InfoPetUI")
local infoCloseButton = InfoPetUI:child("CloseButton")
local infoPetName = InfoPetUI:child("PetName")
local infoActorWindow = InfoPetUI:child("ActorWindow")
local infoAtk = InfoPetUI:child("Atk")
local infoHp = InfoPetUI:child("HP")
local infoLevel = InfoPetUI:child("Level")
local infoCount = InfoPetUI:child("Count")
local infoSummonButton = InfoPetUI:child("SummonButton")
local infoReturnButton = InfoPetUI:child("ReturnButton")
local infoUpgradeButton = InfoPetUI:child("UpgradeButton")
local infoRemoveButton = InfoPetUI:child("RemoveButton")
local player, petNode

----------------------------------- UpgradePetUI -----------------------------------
local UpgradePetUI = self:child("UpgradePetUI")
local upgradeCloseButton = UpgradePetUI:child("CloseButton")
local upgradePetName = UpgradePetUI:child("PetName")
local upgradeActorWindowIndex = UpgradePetUI:child("ActorWindowIndex")
local upgradeActorWindowIndex1 = UpgradePetUI:child("ActorWindowIndex1")
local upgradeActorWindowResult = UpgradePetUI:child("ActorWindowResult")
local upgradeAtkIndex = UpgradePetUI:child("AtkIndex")
local upgradeHpIndex = UpgradePetUI:child("HPIndex")
local upgradeAtkResult = UpgradePetUI:child("AtkResult")
local upgradeHpResult = UpgradePetUI:child("HPResult")
local upgradeLevelResult = UpgradePetUI:child("Level")
local upgradeYesButton = UpgradePetUI:child("YesButton")
local upgradeProgressBar = UpgradePetUI:child("ProgressBar")
local upgradeCover = UpgradePetUI:child("Cover")
local upgradeCover1 = UpgradePetUI:child("Cover1")
local timer
local timeToUpgrade = 5

----------------------------------- NotifyUI -----------------------------------
local NotifyUI = self:child("NotifyUI")
local notifyCloseButton = NotifyUI:child("CloseButton")
local notifyHeader = NotifyUI:child("Header")
local notifyContent = NotifyUI:child("Content")

----------------------------------- LuckyWheelUI -----------------------------------
local LuckyWheelUI = self:child("LuckyWheelUI")
local luckyCloseButton = LuckyWheelUI:child("CloseButton")
local luckyDiamondButton = LuckyWheelUI:child("DiamondButton")
local luckyGCubeButton = LuckyWheelUI:child("GCubeButton")
local luckyX1WithDiamond = LuckyWheelUI:child("X1WithDiamond")
local luckyX10WithDiamond = LuckyWheelUI:child("X10WithDiamond")
local luckyX1WithGCube = LuckyWheelUI:child("X1WithGCube")
local luckyX10WithGCube = LuckyWheelUI:child("X10WithGCube")
local luckyWheelInfo = {}
local totalWheelInfo = {}
local luckySlot = {}
local rollType
local rollCount
local PayUI = self:child("PayUI")
local payCloseButton = PayUI:child("CloseButton")
local payContent = PayUI:child("Content")
local payYesButton = PayUI:child("YesButton")
local payNoButton = PayUI:child("NoButton")
local PrizeProgressUI = self:child("PrizeProgressUI")
local prizeTotalWheel = PrizeProgressUI:child("ProgressBar")														

-------------------------------------------------------------------------------------------
local function clickSound()
	local TdAudioEngine = TdAudioEngine.Instance()
	local soundID = TdAudioEngine.Instance():play2dSound("asset/Sound/click.mp3", false)
	-- print("soundID"..soundID)
	TdAudioEngine:setSoundsVolume(soundID,0.4)
end
local function refreshProcess(totalTime, curTime)
    local progress = curTime / totalTime
    upgradeProgressBar:setProperty("CurrentProgress", progress)
end


----------------------------------- LefUI -----------------------------------
LefTeleButton.onMouseClick = function ()
    print("teleport")  
	-- clickSound()
	LefUI:setVisible(false)
	TeleUI:setVisible(true)
end

lefInventoryButton.onMouseClick = function ()
    print("inventory")
	-- clickSound()
	LefUI:setVisible(false)
	InventoryUI:setVisible(true)
end

lefLuckyWheelButton.onMouseClick = function ()
	print("lucky wheel")
	-- clickSound()
	LefUI:setVisible(false)
	LuckyWheelUI:setVisible(true)
end

PackageHandlers.registerClientHandler("Summoning", function(player, pack)
	local summoned = pack[1]
	local maxSummon = pack[2]
	Summoning:setText(summoned.."/"..maxSummon)
	print("Summoning")
end)
----------------------------------- TeleUI -----------------------------------
teleCloseButton.onMouseClick = function ()
	-- clickSound()
	UI:closeWindow("Gui/InventoryUI")
	UI:openWindow("Gui/InventoryUI")
end

shop.onMouseClick = function ()
	-- clickSound()
	UI:openWindow("Gui/Gate/openShopUI_Gate_1")
	PackageHandlers.sendClientHandler("Get Gate Fee Diamond", shop.Name)
	-- UI:closeWindow("Gui/InventoryUI")
end

zone1.onMouseClick = function ()
	-- clickSound()
	UI:openWindow("Gui/Gate/openShopUI_Gate_1")
	PackageHandlers.sendClientHandler("Get Gate Fee Diamond", zone1.Name)
	-- UI:closeWindow("Gui/InventoryUI")
end

zone2.onMouseClick = function ()
	-- clickSound()
	UI:openWindow("Gui/Gate/openShopUI_Gate_1")
	PackageHandlers.sendClientHandler("Get Gate Fee Diamond", zone2.Name)
	-- UI:closeWindow("Gui/InventoryUI")
end
zone3.onMouseClick = function ()
	-- clickSound()
	UI:openWindow("Gui/Gate/openShopUI_Gate_1")
	PackageHandlers.sendClientHandler("Get Gate Fee Diamond", zone3.Name)
	-- UI:closeWindow("Gui/InventoryUI")
end

----------------------------------- InventoryUI -----------------------------------
PackageHandlers.sendOtherClient(Me.platformUserId, "Get Inventory Data")


clickTutorial.onMouseClick = function()
	PackageHandlers.sendClientHandler("Return All Pets")
	PackageHandlers.sendClientHandler("Quick Summon Pets")
	UI:closeWindow(self)
    UI:openWindow("Gui/InventoryUI")
	print("Quick Summon")
end
inventCloseButton.onMouseClick = function()
	LefUI:setVisible(true)
	InventoryUI:setVisible(false)
	-- UI:closeWindow(self)
	-- UI:openWindow("Gui/InventoryUI")
	-- clickSound()
end


PackageHandlers.registerClientHandler("InventoryTutorial", function(_player)
	print("Vao day")
	LefUI:setVisible(false)
	InventoryUI:setVisible(true)
	bg:setVisible(true)
	clickTutorial:setVisible(true)
	EffectWindowPoint1:setVisible(true)
end)

PackageHandlers.registerClientHandler("Return Inventory Data", function(_player, pack)
	print("Inventory Updated")
	inventory = pack[1]
	playerCfg = pack[2]
	-- print(Lib.pv(pack))
	player = _player
	if inventory == nil then
		print("Inventory is nil")
		return
	end
	print("Thong bao playercfg")
	if (playerCfg ~= nil) then
		local inventCount = 0
		for i = 1, #inventory do
			inventCount = inventCount + inventory[i].Count
			inventInventoryCount:setText(inventCount .. "/" .. playerCfg.MaxSlot)
		end
	end

	for k, v in pairs(inventGridView:GetChildren()) do
		if k ~= 1 then
			print("K: "..k)
			v:Destroy()
		end
	end

	for i = 1, #inventory do
		if (i == 1) then
			inventSlotImg:setImage(inventory[i].Label)
			inventSlotCount:setText("Count: " .. inventory[i].Count)
			inventSlotLevel:setText("Lv: " .. inventory[i].Level)

			inventSlotButton.onMouseClick = function()
				-- clickSound()
				print("pressed slot "..i)
				if(inventory[i] ~= nil) then
					print("inventory[i] ~= nil")
					InfoPetUI:setProperty("Visible", "True")
					InventoryUI:setProperty("Visible", "False")
					petNode = inventory[i]
					print("Return Pet Info")
					local name = petNode.Name

					infoPetName:setText(name)
					print(name .. ".actor")
					infoActorWindow:setActorName(name .. ".actor")
					infoAtk:setText(tonumber(petNode.Atk))
					infoHp:setText(petNode.HP)
					infoLevel:setText(petNode.Level)
					infoCount:setText(petNode.Count)
				end 
			end
		else
			local newSlotImg = inventSlotImg:clone()
			newSlotImg.name = "Slot"..i
			inventGridView:addChild(newSlotImg:getWindow())

			local newSlotButton = newSlotImg:child("SlotBtn1")
			local newSlotCount = newSlotImg:child("Count1")
			local newSlotLevel = newSlotImg:child("Level1")
			newSlotImg:setImage(inventory[i].Label)
			newSlotCount:setText("Count: " .. inventory[i].Count)
			newSlotLevel:setText("Lv: " .. inventory[i].Level)

			newSlotButton.onMouseClick = function()
				-- clickSound()
				print("pressed slot "..i)
				if(inventory[i] ~= nil) then
					print("inventory[i] ~= nil")
					InfoPetUI:setProperty("Visible", "True")
					InventoryUI:setProperty("Visible", "False")
					petNode = inventory[i]
					print("Return Pet Info")
					local name = petNode.Name

					infoPetName:setText(name)
					print(name .. ".actor")
					infoActorWindow:setActorName(name .. ".actor")
					infoAtk:setText(tonumber(petNode.Atk))
					infoHp:setText(petNode.HP)
					infoLevel:setText(petNode.Level)
					infoCount:setText(petNode.Count)
				end 
			end
		end
	end
end)

inventQuickSummonButton.onMouseClick = function()
	-- clickSound()
	PackageHandlers.sendClientHandler("Return All Pets")
	PackageHandlers.sendClientHandler("Quick Summon Pets")
	UI:closeWindow(self)
    UI:openWindow("Gui/InventoryUI")
	print("Quick Summon")
end



inventReturnAllPetButton.onMouseClick = function()
	-- clickSound()
	PackageHandlers.sendClientHandler("Return All Pets")
	UI:closeWindow(self)
    UI:openWindow("Gui/InventoryUI")
	print("Return All Pet")
end

----------------------------------- InfoPetUI -----------------------------------

infoSummonButton.onMouseClick = function()
    print("Summon Button")
	-- clickSound()
    PackageHandlers.sendClientHandler("Summon Pet", {petNode.Slot, 1})
    UI:closeWindow(self)
    UI:openWindow("Gui/InventoryUI")
end



infoReturnButton.onMouseClick = function()
    print("Return Button")
	-- clickSound()
    PackageHandlers.sendClientHandler("Return Pet", petNode.Slot)
    UI:closeWindow(self)
    UI:openWindow("Gui/InventoryUI")
end


infoRemoveButton.onMouseClick = function()
    print("Remove Button")
	-- clickSound()
    PackageHandlers.sendClientHandler("Remove Pet", {petNode.Slot, 1})
    UI:closeWindow(self)
    UI:openWindow("Gui/InventoryUI")
end


infoUpgradeButton.onMouseClick = function()
    InfoPetUI:setProperty("Visible", "False")
	UpgradePetUI:setProperty("Visible", "True")
	-- clickSound()
	local name = petNode.Name

    if(petNode.Count == 1) then
        upgradeCover:setVisible(true)
        upgradeCover1:setVisible(true)
    end

    upgradeActorWindowIndex:setActorName(name .. ".actor")
    upgradeActorWindowIndex1:setActorName(name .. ".actor")
    upgradeActorWindowResult:setActorName(name .. ".actor")
    upgradeAtkIndex:setText(petNode.Atk)
    upgradeHpIndex:setText(petNode.HP)
    upgradeAtkResult:setText(math.floor(petNode.Atk * 2 * 10) / 10)     --- làm tròn sau dấu phẩy 2 chữ số thập phân
    upgradeHpResult:setText(math.floor(petNode.HP * 2 * 10) / 10)
    upgradeLevelResult:setText(petNode.Level+1)
end


infoCloseButton.onMouseClick = function()
	-- clickSound()
    InfoPetUI:setProperty("Visible", "False")
	InventoryUI:setProperty("Visible", "True")
end


----------------------------------- UpgradePetUI -----------------------------------

upgradeCloseButton.onMouseClick = function()
	-- clickSound()
	UpgradePetUI:setProperty("Visible", "False")
	InfoPetUI:setProperty("Visible", "True")
end
local function Countdown(func)
    local time = 0
    local totalTime = timeToUpgrade * 20
    World.Timer(1, function()
        time = time + 1
        refreshProcess(totalTime, time)
        if time >= totalTime then
            print("Success")
            func()
            return
        end
        return 1
    end)
end

upgradeYesButton.onMouseClick = function()
	-- clickSound()
    if petNode.Count > 1 then
		upgradeProgressBar:setProperty("Visible", "True")
		upgradeCloseButton:setProperty("Visible", "False")
		upgradeYesButton:setProperty("Visible", "False")
        Countdown(function()
            PackageHandlers.sendClientHandler("Upgrade Pet", petNode.Slot)
			upgradeProgressBar:setProperty("Visible", "False")
			upgradeCloseButton:setProperty("Visible", "True")
			upgradeYesButton:setProperty("Visible", "True")
			UI:closeWindow("Gui/InventoryUI")
            UI:openWindow("Gui/InventoryUI")
        end)
    end
end


----------------------------------- NotifyUI -----------------------------------
PackageHandlers.registerClientHandler("Show Notify", function(_player, pack)
	NotifyUI:setProperty("Visible", "True")
	notifyHeader:setText(pack.Header)
	notifyContent:setText(pack.Content)
end)

notifyCloseButton.onMouseClick = function()
	-- clickSound()
	NotifyUI:setProperty("Visible", "False")
end


----------------------------------- LuckyWheelUI -----------------------------------

PackageHandlers.sendClientHandler("Get Lucky Wheel Info")

PackageHandlers.registerClientHandler("Return Lucky Wheel Info", function(_player, pack)
	luckyWheelInfo = pack[1]
	totalWheelInfo = pack[2]
	-- print(Lib.pv(totalWheelInfo))
	print("Returned Lucky Wheel Info")
end)

local function setLuckyWheelInfo(type)
	print("Set Lucky Wheel Info")
	-- print(Lib.pv(totalWheelInfo))
	for i = 1, 10 do
		local img = LuckyWheelUI:child("Slot"..i)
		img:setImage(luckyWheelInfo[type][i][1].Label)
		local atk = LuckyWheelUI:child("AtkBtn"..i)
		atk:setText(luckyWheelInfo[type][i][1].Atk)
		print(luckyWheelInfo[type][i][1].Label)
		print(luckyWheelInfo[type][i][1].Atk)
	end
	print(totalWheelInfo[type].Value)
	prizeTotalWheel:setProperty("CurrentProgress", totalWheelInfo[type].Value/100)
	for i = 1, 10, 1 do
		local prize = LuckyWheelUI:child("Prize"..i)
		prize:setImage(luckyWheelInfo.StagesPrize[type][tostring(i*10)].Label)
		local claim = LuckyWheelUI:child("Claim"..i)
		claim.onMouseClick = function()
			local totalInventorySlot = 0
			for key, value in pairs(inventory) do
				totalInventorySlot = totalInventorySlot + value.Count
			end
			print("Claiming " .. i .. totalWheelInfo[type].Value)
			if i*10 <= totalWheelInfo[type].Value then
				-- số slot hiện tại của inventory + (số vòng quay/10 - số prize đã nhận) > maxSlot
				if totalInventorySlot + (math.floor(totalWheelInfo[type].Value/10) - totalWheelInfo[type].ClaimStages) > playerCfg.MaxSlot then
					print("Inventory Full")
					PackageHandlers.sendClientHandler("Send Tip", "Inventory is full!")
				else
					PackageHandlers.sendClientHandler("Claim Lucky Wheel", type)
				end
			end
		end
		if i*10 - totalWheelInfo[type].Value <= 10 and i*10 - totalWheelInfo[type].Value >= -9 then
			prize:setProperty("Visible", "True")
			print("Show Prize " .. i)
		elseif i ~= 10 then
			prize:setProperty("Visible", "False")
		end
	end
	print("Set Info")
end

local function rollWheel(mode, slot)
	local result = slot
	luckyCloseButton:setProperty("Visible", "False")
	slot = math.random(2, 3) * 10 + slot[1]
	print(slot)
	local i = 1
	World.Timer(5, function()
		print(i%10)
		local select = 0
		if i%10 ~= 0 then
			select = LuckyWheelUI:child("Select"..i%10)
			select:setProperty("Visible", "True")
		else
			select = LuckyWheelUI:child("Select10")
			select:setProperty("Visible", "True")
		end

		World.Timer(5, function()
			if(i <= slot) then
				select:setProperty("Visible", "False")
			else
				LuckyWheelUI:setProperty("Visible", "False")
				UI:openWindow("Gui/PetReceiveUI")
				if mode == 1 then
					if (i-1)%10 ~= 0 then
						PackageHandlers.sendOtherClient(player.platformUserId, "Return Pet Received", {{luckyWheelInfo[rollType][(i-1)%10][1]}, false})
						print(Lib.pv(luckyWheelInfo[rollType][(i-1)%10][1]))
					else
						PackageHandlers.sendOtherClient(player.platformUserId, "Return Pet Received", {{luckyWheelInfo[rollType][10][1]}, false})
						print(Lib.pv(luckyWheelInfo[rollType][10][1]))
					end
				elseif mode == 10 then
					print(Lib.pv(result))
					for i = 1, 10, 1 do
						result[i] = luckyWheelInfo[rollType][result[i]][1]
					end
					PackageHandlers.sendOtherClient(player.platformUserId, "Return Pet Received", {result, false, true})
				end
			end
		end)
		i = i + 1
		if(i <= slot) then
			return 5
		end
	end)
end


luckyCloseButton.onMouseClick = function()
	-- clickSound()
	LuckyWheelUI:setProperty("Visible", "False")
	LefUI:setProperty("Visible", "True")

	luckyDiamondButton:setProperty("Visible", "True")
	luckyGCubeButton:setProperty("Visible", "True")
	luckyDiamondButton:setProperty("Selected", "False")
	luckyGCubeButton:setProperty("Selected", "False")
	luckyX1WithDiamond:setProperty("Visible", "False")
	luckyX10WithDiamond:setProperty("Visible", "False")
	luckyX1WithGCube:setProperty("Visible", "False")
	luckyX10WithGCube:setProperty("Visible", "False")
end

luckyDiamondButton.onSelectStateChanged = function(instance, toggle)
	-- clickSound()
	if luckyDiamondButton:isSelected() then
		luckyDiamondButton:setProperty("Visible", "False")
		luckyX1WithDiamond:setProperty("Visible", "True")
		luckyX10WithDiamond:setProperty("Visible", "True")
		luckyGCubeButton:setProperty("Visible", "True")
		luckyGCubeButton:setProperty("Selected", "False")
		luckyX1WithGCube:setProperty("Visible", "False")
		luckyX10WithGCube:setProperty("Visible", "False")
	
		setLuckyWheelInfo("Diamond")
		rollType = "Diamond"
	end
end

luckyGCubeButton.onMouseClick = function()
	-- clickSound()
	if luckyGCubeButton:isSelected() then
		luckyGCubeButton:setProperty("Visible", "False")
		luckyX1WithGCube:setProperty("Visible", "True")
		luckyX10WithGCube:setProperty("Visible", "True")
		luckyDiamondButton:setProperty("Visible", "True")
		luckyDiamondButton:setProperty("Selected", "False")
		luckyX1WithDiamond:setProperty("Visible", "False")
		luckyX10WithDiamond:setProperty("Visible", "False")
		setLuckyWheelInfo("GCube")
		rollType = "GCube"
	end
end

luckyX1WithDiamond.onMouseClick = function()
	-- clickSound()
	luckyGCubeButton:setProperty("Visible", "False")
	luckyX1WithGCube:setProperty("Visible", "False")
	luckyX10WithGCube:setProperty("Visible", "False")
	luckyDiamondButton:setProperty("Visible", "False")
	luckyX1WithDiamond:setProperty("Visible", "False")
	luckyX10WithDiamond:setProperty("Visible", "False")

	rollCount = 1
	PayUI:setProperty("Visible", "True")
	payContent:setText("Use " .. luckyWheelInfo.Price[rollType] * rollCount .. " " .. rollType .. " to roll x" .. rollCount .. "\nLucky Wheel?")
end

luckyX1WithGCube.onMouseClick = function()
	-- clickSound()
	luckyGCubeButton:setProperty("Visible", "False")
	luckyX1WithGCube:setProperty("Visible", "False")
	luckyX10WithGCube:setProperty("Visible", "False")
	luckyDiamondButton:setProperty("Visible", "False")
	luckyX1WithDiamond:setProperty("Visible", "False")
	luckyX10WithDiamond:setProperty("Visible", "False")

	rollCount = 1
	PayUI:setProperty("Visible", "True")
	payContent:setText("Use " .. luckyWheelInfo.Price[rollType] * rollCount .. " " .. rollType .. " to roll x" .. rollCount .. "\nLucky Wheel?")
end

luckyX10WithDiamond.onMouseClick = function()
	-- clickSound()
	luckyGCubeButton:setProperty("Visible", "False")
	luckyX1WithGCube:setProperty("Visible", "False")
	luckyX10WithGCube:setProperty("Visible", "False")
	luckyDiamondButton:setProperty("Visible", "False")
	luckyX1WithDiamond:setProperty("Visible", "False")
	luckyX10WithDiamond:setProperty("Visible", "False")

	rollCount = 10
	PayUI:setProperty("Visible", "True")
	payContent:setText("Use " .. luckyWheelInfo.Price[rollType] * rollCount .. " " .. rollType .. " to roll x" .. rollCount .. "\nLucky Wheel?")
end

luckyX10WithGCube.onMouseClick = function()
	-- clickSound()
	luckyGCubeButton:setProperty("Visible", "False")
	luckyX1WithGCube:setProperty("Visible", "False")
	luckyX10WithGCube:setProperty("Visible", "False")
	luckyDiamondButton:setProperty("Visible", "False")
	luckyX1WithDiamond:setProperty("Visible", "False")
	luckyX10WithDiamond:setProperty("Visible", "False")

	rollCount = 10
	PayUI:setProperty("Visible", "True")
	payContent:setText("Use " .. luckyWheelInfo.Price[rollType] * rollCount .. " " .. rollType .. " to roll x" .. rollCount .. "\nLucky Wheel?")
end

payCloseButton.onMouseClick = function()
	-- clickSound()
	PayUI:setProperty("Visible", "False")
end

payNoButton.onMouseClick = function()
	-- clickSound()
	PayUI:setProperty("Visible", "False")
end

payYesButton.onMouseClick = function()
	-- clickSound()
	PayUI:setProperty("Visible", "False")
	print(Lib.pv(inventory))
	local totalInventorySlot = 0
	for key, value in pairs(inventory) do
		totalInventorySlot = totalInventorySlot + value.Count
	end
	print(totalInventorySlot)
	if totalInventorySlot + rollCount > playerCfg.MaxSlot then
		print("Inventory Full")
		PackageHandlers.sendClientHandler("Send Tip", "Inventory is full!")
		return
	else
		print("Khong full")
		PackageHandlers.sendClientHandler("Roll Lucky Wheel", {rollType, rollCount})
	end
end

PackageHandlers.registerClientHandler("Return Lucky Wheel Result", function(player, rollResult)
	rollWheel(#rollResult, rollResult)
	totalWheelInfo[rollType].Value = totalWheelInfo[rollType].Value + #rollResult
	setLuckyWheelInfo(rollType)
end)
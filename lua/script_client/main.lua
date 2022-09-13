print("script_client:hello world")
require "script_client.DataStorage"
UI:openWindow("sevenLoginWnd")
-- Blockman.Instance().gameSettings:setExtraCameraDistance(2.0)

local function clickSound()
	local TdAudioEngine = TdAudioEngine.Instance()
	local soundID = TdAudioEngine.Instance():play2dSound("asset/Sound/openegg.mp3", false)
	TdAudioEngine:setSoundsVolume(soundID,0.4)
end
PackageHandlers.registerClientHandler("showOrCloseGuide3", function(player, packet)
    local pos = packet.guidePos
    if pos then
        Me:setGuideTarget(pos, 'guide.png', 0.1)
    else
        Me:delGuideTarget()
    end
end)
PackageHandlers.registerClientHandler("showOrCloseGuide", function(player, packet)
    local pos = packet.guidePos
    if pos then
        Me:setGuideTarget(pos, 'guide.png', 0.1)
    else
        Me:delGuideTarget()
    end
end)
PackageHandlers.registerClientHandler("showOrCloseGuide2", function(player, packet)---Chạy đến region shop pet.--->người chơi tiến vào region shop pet -->openui tutorial 8 
    local pos = packet.guidePos
    if pos then
        Me:setGuideTarget(pos, 'guide.png', 0.1)
    else
        Me:delGuideTarget()
    end
end)

PackageHandlers.registerClientHandler("LoadingUi",function(player)
        UI:openWindow("Gui/LoadingUi")
end)
PackageHandlers.registerClientHandler("OnlineUi",function(player)
          UI:openWindow("Gui/OnlineUi")
end)
PackageHandlers.registerClientHandler("StepCuoc",function(player,value)---Hướng dẫn farm
    if value.first == 4 then
        UI:openWindow("Gui/TutorialStep4")---kết thúc và mở TutorialStep5
    end
end)
PackageHandlers.registerClientHandler("Step12",function(player,value)---Hướng dẫn farm
    if value.first == 7 then
        UI:openWindow("Gui/TutorialStep9")---kết thúc và mở TutorialStep5
    end
end)
PackageHandlers.registerClientHandler("Step7",function(player,value)---Hướng dẫn farm
    if value.first == 5 then
        UI:openWindow("Gui/TutorialStep5")---kết thúc và mở TutorialStep5
    end
end)
PackageHandlers.registerClientHandler("Step5",function(player,value)---Hướng dẫn farm
    if value.first == 4 then
        print("OpenStep5")
        World.Timer(10*20, function()
            UI:openWindow("Gui/TutorialStep3")--- Open ui 3 hướng dẫn farm
        end)
    end
end)


PackageHandlers.registerClientHandler("OpenStep1",function(player,value)
    if value.first == 1 then
        UI:openWindow("Gui/OnlineUiFirst")
    else
        UI:openWindow("Gui/OnlineUi")
    end
end)

PackageHandlers.registerClientHandler("openShopUI_Gate", function(player, pack)
    UI:openWindow("Gui/Gate/openShopUI_Gate_1")
    PackageHandlers.sendClientHandler("Get Gate Fee", pack)
end)

PackageHandlers.registerClientHandler("Open Egg Shop", function(player, shopData)
    -- clickSound()
    UI:openWindow("Gui/Egg/simpleShop")
    local userID = player.platformUserId
    PackageHandlers.sendOtherClient(userID, "Return Egg Shop Data", shopData)

end)

PackageHandlers.registerClientHandler("openUI",function(player, money)
    UI:openWindow("Gui/interfaceInfo")
    PackageHandlers.sendOtherClient(player.platformUserId, "Money Updated", money)
    print("UI opened...!")
end)

PackageHandlers.registerClientHandler("closeUI",function()
    UI:closeWindow("Gui/interfaceInfo")
    print("UI closed...!")
end)

PackageHandlers.registerClientHandler("Pet Received", function(player, petData)
    UI:openWindow("Gui/PetReceiveUI")
    -- print("Debug")
	-- print(petData.Name)	
    -- print(Lib.pv(petData))		   
    PackageHandlers.sendOtherClient(player.platformUserId, "Return Pet Received", petData)
end)

PackageHandlers.registerClientHandler("openUIPet",function()
    print("openUIPet")
    -- UI:openWindow("Gui/LeftUI")
    UI:openWindow("Gui/InventoryUI")
end)

-- PackageHandlers.registerClientHandler("openTutorial",function()
--     print("openTutorial")
--     UI:openWindow("Gui/Tutorial")
-- end)

PackageHandlers.registerClientHandler("closeUIPet",function()
    print("openUIPet")
    -- UI:openWindow("Gui/LeftUI")
    UI:closeWindow("Gui/InventoryUI")
end)

PackageHandlers.registerClientHandler("openShopUI", function()
    UI:openWindow("Gui/simpleShop")
end)

PackageHandlers.registerClientHandler("currencyConversion", function (player, count)
    UI:openWindow("Gui/currencyUi")
    PackageHandlers.sendOtherClient(player.platformUserId, "Return Currency Count", count)
    print("open currencyUi")
end)

PackageHandlers.registerClientHandler("Add Effect Speed", function(player, pack)
    local name = pack[1]
    local effectName = pack[2]
    local once = pack[3]
    local pos = pack[4]
    local yaw = pack[5]
    local scale = pack[6]
    player:addEffect(name, effectName, once, pos, yaw, scale)
    -- print("Effect added")
end)
PackageHandlers.registerClientHandler("Add Effect Money", function(player, pack)
    local name = pack[1]
    local effectName = pack[2]
    local once = pack[3]
    local pos = pack[4]
    local yaw = pack[5]
    local scale = pack[6]
    player:addEffect(name, effectName, once, pos, yaw, scale)
    -- print("Effect added")
end)
PackageHandlers.registerClientHandler("Add Effect Atk", function(player, pack)
    local name = pack[1]
    local effectName = pack[2]
    local once = pack[3]
    local pos = pack[4]
    local yaw = pack[5]
    local scale = pack[6]
    player:addEffect(name, effectName, once, pos, yaw, scale)
    -- print("Effect added")
end)

--===========================================================

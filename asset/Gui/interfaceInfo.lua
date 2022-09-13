print("startup ui")
-- Refresh remaining currency text
local speedTxt = self:child("Txt_speed")
local atkTxt = self:child("Txt_atk")
local diamondTxt = self:child("Txt_gold")   -- left money
local goldTxt = self:child("Txt_gold1")   -- left money
local fantasyCoinTxt = self:child("Txt_gold2")   -- left money
local techCoinTxt = self:child("Txt_gold3")   -- left money
local pixelCoinTxt = self:child("Txt_gold4")   -- left money

local fiveEggsMode = self:child("FiveEggsMode")
-- local killButton = self:child("KillButton")
local AddAtk = self:child("AddAtk")
local money, player, playerCfg
PackageHandlers.registerClientHandler("Money Updated", function(_player, value)
    money = value
    player = _player
    local speed = Me:prop("moveSpeed")
    local atk = Me:prop('damage')
    print("Money Updated UI")
    -- print(Lib.v2s(skillCfg))
    -- print(Lib.v2s(skillCfg))
    -- print(Lib.v2s(player))
    speedTxt:setText(speed)
    atkTxt:setText("Pickaxe Atk : "..atk)
    diamondTxt:setText(money.Diamond)
    goldTxt:setText(money.Gold)
    fantasyCoinTxt:setText(money.FantasyCoin)
    techCoinTxt:setText(money.TechCoin)
    pixelCoinTxt:setText(money.PixelCoin)
    if money.Gold >= 300  then -- old 300 
        PackageHandlers.sendClientHandler("Step8")-----sau khi farm xong 300gold chuyển đến bước 8 server show arrow
    end
end)


PackageHandlers.registerClientHandler("Get 5 Eggs Mode", function(player)
    PackageHandlers.sendOtherClient(player.platformUserId, "Return 5 Eggs Mode", fiveEggsMode:isSelected())
end)


PackageHandlers.registerClientHandler("PlayerCfg Updated", function(player, value)
    playerCfg = value
    if playerCfg.FiveEggsMode then
        fiveEggsMode:setVisible(true)
    end
    PackageHandlers.sendOtherClient(player.platformUserId, "Return PlayerCfg", playerCfg)
end)

-- killButton.onMouseClick = function()
--     PackageHandlers.sendClientHandler("Kill Button Clicked")
-- end

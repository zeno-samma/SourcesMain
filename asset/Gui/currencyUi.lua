print("startup ui")
---------------------------------- SelectType ----------------------------------
local SelectTypeUI = self:child("SelectType")
local closeButtonSelectType = SelectTypeUI:child("closeButtonType")
local yesButtonSelectGold = SelectTypeUI:child("yesButton1")
local yesButtonSelectDiamond = SelectTypeUI:child("yesButton2")
---------------------------------- ExchangeGold ----------------------------------
local ExchangeGoldUI = self:child("ExchangeGold")
local closeButtonExchangeGold = ExchangeGoldUI:child("closeButtonGold")
local yesButtonExchangeGold = ExchangeGoldUI:child("yesButtonGold")
local curCountExchangeGold = ExchangeGoldUI:child("curCountGold")
local EditboxExchangeGold = ExchangeGoldUI:child("EditboxGold")
---------------------------------- ExchangeDiamond ----------------------------------
local ExchangeDiamondUI = self:child("ExchangeDiamond")
local closeButtonExchangeDiamond = ExchangeDiamondUI:child("closeButtonDiamond")
local yesButtonExchangeDiamond = ExchangeDiamondUI:child("yesButtonDiamond")
local curCountExchangeDiamond = ExchangeDiamondUI:child("curCountDiamond")
local EditboxExchangeDiamond = ExchangeDiamondUI:child("EditboxDiamond")
--------------------------------------------------------------------
local curCountGold,curCountDiamond
closeButton = self:child("closeButton")

PackageHandlers.registerClientHandler("Return Currency Count", function(player,pack)
    -- print("===>curCount")
    -- print(Lib.pv(pack))
    curCountGold = tonumber(pack[1])
    curCountDiamond = tonumber(pack[2])
    curCountExchangeGold:setText(pack[1])
    curCountExchangeDiamond:setText(pack[2])
    UI:openWindow("Gui/currencyUi")
end)

----------------------------------- SelectType -----------------------------------
yesButtonSelectGold.onMouseClick = function ()
    print("Select Gold")
	SelectTypeUI:setVisible(true)
	ExchangeGoldUI:setVisible(true)
	ExchangeDiamondUI:setVisible(false)
end

yesButtonSelectDiamond.onMouseClick = function ()
    print("Select Gold")
	ExchangeGoldUI:setVisible(false)
	ExchangeDiamondUI:setVisible(true)
end
--------------------------------------------------------------------
closeButton.onMouseClick = function()
    UI:closeWindow("Gui/currencyUi")
end

yesButtonExchangeGold.onMouseClick = function()
    local count = tonumber(EditboxExchangeGold:getText())
    if(count <= curCountGold) then
        PackageHandlers.sendClientHandler("Exchange Currency Gold", count)
        -- player:sendTip(2, "Success", 40)
        UI:closeWindow("Gui/currencyUi")
    end
end

yesButtonExchangeDiamond.onMouseClick = function()
    local count = tonumber(EditboxExchangeDiamond:getText())
    -- player:sendTip(2, "Not Enough Gold", 40)
    if(count <= curCountDiamond) then
        PackageHandlers.sendClientHandler("Exchange Currency Diamond", count)
        -- player:sendTip(2, "Success", 40)
        UI:closeWindow("Gui/currencyUi")
    end
    UI:closeWindow("Gui/currencyUi")
end

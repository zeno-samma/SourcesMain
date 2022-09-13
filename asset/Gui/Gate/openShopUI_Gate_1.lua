print("startup ui")
-- Get the child control through self:child("child control name")
local img = self:child("Image")
local yesButton = self:child("Btn")
local closeButton = img:child("Btn_close")
local gateTxt = img:child("Text")
local questionTxt = img:child("Text1")
local feeTxt = img:child("Text2")
local gate, fee, moneyType

print("UI Open")
PackageHandlers.registerClientHandler("Return Gate Fee", function(player, pack)
    gate = pack[1]
    fee = pack[2]
    moneyType = "Gold"
    
    gateTxt:setText(gateTxt:getText()..gate)
    questionTxt:setText(questionTxt:getText().. " " .. gate)
    feeTxt:setText("Price: $".. fee)
end)

PackageHandlers.registerClientHandler("Return Gate Fee Diamond", function(player, pack)
    gate = pack[1]
    fee = pack[2]
    moneyType = "Diamond"
    
    gateTxt:setText(gateTxt:getText()..gate)
    questionTxt:setText(questionTxt:getText().. " " .. gate)
    feeTxt:setText("Price: ".. fee .. " Diamond")
end)


yesButton.onMouseClick = function()
    print("yes")
    PackageHandlers.sendClientHandler("Tele", {moneyType, gate})
    if(moneyType == "Diamond") then
        UI:closeWindow("Gui/TeleUI")
    end
    -- UI:openWindow("Gui/InventoryUI")
    UI:closeWindow(self)
    -- PackageHandlers.sendClientHandler("Step4") --->sau khi click cổng chuyển đến bước 4-->server
end

closeButton.onMouseClick = function()
    UI:closeWindow(self)
    UI:openWindow("Gui/InventoryUI")
end

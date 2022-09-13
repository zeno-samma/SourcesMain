print("startup ui")
local yesButton = self:child("YesButton")
local closeButton = self:child("CloseButton") 
local name = self:child("Name")
local label = self:child("Label")
local rate = {
    self:child("Rate1"),
    self:child("Rate2"),
    self:child("Rate3"),
    self:child("Rate4"),
    self:child("Rate5")
}
local shopData, fiveEggsMode = false

local function showData(shopData)
    name:setText(shopData.Name)
    label:setImage(shopData.Label)
    yesButton:setText(shopData.Price)
    local rateText
    for i = 1, #rate do
        if (i <= #shopData.PetList) then
            rateText = shopData.PetList[i][1] .. " (" .. shopData.PetList[i][2] .. "%)"
        else
            rateText = ""
        end
        rate[i]:setText(rateText)
    end

    if fiveEggsMode then
        yesButton:setText(shopData.Price * 5 .. " (5 Eggs)")
    end
end

PackageHandlers.registerClientHandler("Return Egg Shop Data", function(player, _shopData)
    shopData = _shopData
    showData(shopData)
end)

PackageHandlers.registerClientHandler("Return 5 Eggs Mode", function(player, _fiveEggsMode)
    fiveEggsMode = _fiveEggsMode
    showData(shopData)
end)



closeButton.onMouseClick = function()
	UI:closeWindow("Gui/Egg/simpleShop")
end

yesButton.onMouseClick = function()
    PackageHandlers.sendClientHandler("Buy Egg", {shopData, fiveEggsMode})
    print(shopData.Name)
	--UI:closeWindow("Gui/Egg/simpleShop")
end

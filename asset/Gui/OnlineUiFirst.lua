print("startup ui")
----------------------------------- OnlineUI & DayGift -----------------------------------
local OnlineUI = self:child("OnlineUI")
local Cover = self:child("Cover")
local dayGiftButton = OnlineUI:child("dayGiftButton")
local ImageGift = OnlineUI:child("ImageGift")
local effectGift = OnlineUI:child("EffectGift")
local DayGift = self:child("DayGift")
local daygiftCloseButton = DayGift:child("closeButton")
local claimButton = DayGift:child("claimButton")
local effectGiftPoint = DayGift:child("EffectWindowPoint")


dayGiftButton.onMouseClick = function ()
	DayGift:setVisible(true)
end

claimButton.onMouseClick = function()
	PackageHandlers.sendClientHandler("Step2")
	DayGift:setVisible(false)
	Cover:setVisible(false)
	OnlineUI:setVisible(false)
	UI:openWindow("Gui/OnlineUi")
end

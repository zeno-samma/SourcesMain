print("startup ui")
local Cover = self:child("Cover")
local Cover = self:child("Cover")
local EffectWindowPoint1 = self:child("EffectWindowPoint1")
local StepButton = self:child("StepButton")

StepButton.onMouseClick = function ()
	UI:closeWindow(self)--->sau khi kết thúc ui TutorialStep5 chờ farm 300 gold check ở interfaceInfo.
	PackageHandlers.sendClientHandler("End tutorial")--sau khi open ui -->click yesbutton-->chuyển đến bước 9 tắt ui arrow
	PackageHandlers.sendOtherClient(Me.platformUserId, "InventoryTutorial")
end


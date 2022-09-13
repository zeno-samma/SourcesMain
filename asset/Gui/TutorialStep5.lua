print("startup ui")
local Cover = self:child("Cover")
local TutorialStep5 = self:child("TutorialStep5")
local Image1 = TutorialStep5:child("Image1")
local EffectWindowPoint1 = TutorialStep5:child("EffectWindowPoint1")
local Step2Button = TutorialStep5:child("Step2Button")

Step2Button.onMouseClick = function ()
	Cover:setVisible(false)
	Image1:setVisible(false)
	UI:closeWindow(self)--->sau khi kết thúc ui TutorialStep5 chờ farm 300 gold check ở interfaceInfo.
	UI:closeWindow("Gui/TutorialStep5")
	PackageHandlers.sendClientHandler("Addspeed")----ket thuc ui click attack coin-->server
end


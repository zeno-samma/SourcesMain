print("startup ui")
local Cover = self:child("Cover")
local TutorialStep3 = self:child("TutorialStep3")
local Image1 = TutorialStep3:child("Image1")
local EffectWindowPoint1 = TutorialStep3:child("EffectWindowPoint1")
local Step2Button = TutorialStep3:child("Step2Button")

Step2Button.onMouseClick = function ()
	Cover:setVisible(false)
	Image1:setVisible(false)
	UI:closeWindow(self)
	UI:closeWindow("Gui/TutorialStep3")
	PackageHandlers.sendClientHandler("Step6")----ket thuc ui click attack coin-->server
end


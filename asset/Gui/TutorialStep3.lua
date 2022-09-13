print("startup ui")
local TutorialStep3 = self:child("TutorialStep3")
local Image = TutorialStep3:child("Image")
local EffectWindowPoint = TutorialStep3:child("EffectWindowPoint")
local Cover = self:child("Cover")
local Step1Button = TutorialStep3:child("Step1Button")

Step1Button.onMouseClick = function ()
	Image:setVisible(false)
	Cover:setVisible(false)
	----Ket thuc step5 tutorial3 chờ người chơi cầm cuốc trên tay--Sever HAND_ITEM_CHANGED --> open ui tutorial4
end


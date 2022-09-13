print("startup ui")
local YesButton = self:child("YesButton")
local EffectWindowPoint = self:child("EffectWindowPoint")

YesButton.onMouseClick = function ()
	PackageHandlers.sendClientHandler("Step3")--Step3
    UI:closeWindow(self)
end
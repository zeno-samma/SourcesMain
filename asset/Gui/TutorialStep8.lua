print("startup ui")
local YesButton = self:child("YesButton")
local EffectWindowPoint = self:child("EffectWindowPoint")

YesButton.onMouseClick = function ()
	-- PackageHandlers.sendClientHandler("Step9")--sau khi open ui -->click yesbutton-->chuyển đến bước 9 tắt ui arrow
    UI:closeWindow(self)
end
print("startup ui")
----------------------------------- OnlineUI & DayGift -----------------------------------
local OnlineUI = self:child("OnlineUI")
local dayGiftButton = OnlineUI:child("dayGiftButton")
local dayGiftProgressBar = OnlineUI:child("ProgressBar")
local dayGiftTime = OnlineUI:child("TimeProgressBar")
local ImageGift = OnlineUI:child("ImageGift")
local ImageGiftDone = OnlineUI:child("ImageGiftDone")
local effectGift = OnlineUI:child("EffectGift")
local DayGift = self:child("DayGift")
local daygiftCloseButton = DayGift:child("closeButton")
local claimButton = DayGift:child("claimButton")
local claimImage = DayGift:child("claimImage")
local effectGiftPoint = DayGift:child("EffectWindowPoint")
local tick1Button = DayGift:child("tick1")
local tick2Button = DayGift:child("tick2")
local tick3Button = DayGift:child("tick3")
local tick4Button = DayGift:child("tick4")
local tick5Button = DayGift:child("tick5")
local EffectWindow1 = DayGift:child("EffectWindow1")
local EffectWindow2 = DayGift:child("EffectWindow2")
local EffectWindow3 = DayGift:child("EffectWindow3")
local EffectWindow4 = DayGift:child("EffectWindow4")
local EffectWindow5 = DayGift:child("EffectWindow5")
local timeToDaygift = 60    --Time
-- local dayGift     --Time
-------------------------------------------------------------------------------------------
-- local function refreshProcessDaygift(totalTime, curTime)
--     local progress = curTime / totalTime
--     dayGiftProgressBar:setProperty("CurrentProgress", progress)
-- end
----------------------------------- DayGiftUI -----------------------------------
-- Day = 0,
-- Count = 0,
-- Last = 0,
-- Flag = 0,
-- Relay_Time = 60*20,--5 phut
-- Timer = 0,--5 phut
-- Use_Max = 6
PackageHandlers.registerClientHandler("Return ClaimAward", function(player, value)
	dayGift = value
	print("Return ClaimAward")
	claimButton:setVisible(true)
	effectGiftPoint:setVisible(true)
	claimImage:setVisible(false)
	effectGift:setVisible(true) --Có quà
	ImageGift:setVisible(false)
end)
PackageHandlers.registerClientHandler("DayGift Updated", function(player, value)
	dayGift = value	
	if dayGift.Count == 1 then
		tick1Button:setVisible(true)
		EffectWindow1:setVisible(false)
	elseif dayGift.Count == 2 then
		tick1Button:setVisible(true)
		tick2Button:setVisible(true)
		EffectWindow1:setVisible(false)
		EffectWindow2:setVisible(false)
	elseif dayGift.Count == 3 then
		tick1Button:setVisible(true)
		tick2Button:setVisible(true)
		tick3Button:setVisible(true)
		EffectWindow1:setVisible(false)
		EffectWindow2:setVisible(false)
		EffectWindow3:setVisible(false)
	elseif dayGift.Count == 4 then
		tick1Button:setVisible(true)
		tick2Button:setVisible(true)
		tick3Button:setVisible(true)
		tick4Button:setVisible(true)
		EffectWindow1:setVisible(false)
		EffectWindow2:setVisible(false)
		EffectWindow3:setVisible(false)
		EffectWindow4:setVisible(false)
	elseif dayGift.Count == 5 then
		-- print("Vao day")
		ImageGiftDone:setVisible(true)
		ImageGift:setVisible(false)
		claimButton:setVisible(false)
		tick1Button:setVisible(true)
		tick2Button:setVisible(true)
		tick3Button:setVisible(true)
		tick4Button:setVisible(true)
		tick5Button:setVisible(true)
		EffectWindow1:setVisible(false)
		EffectWindow2:setVisible(false)
		EffectWindow3:setVisible(false)
		EffectWindow4:setVisible(false)
		EffectWindow5:setVisible(false)
		effectGiftPoint:setVisible(false)
		claimButton:setVisible(false)
	end
end)	

dayGiftButton.onMouseClick = function ()
	DayGift:setVisible(true)
	-- dayGiftButton:setVisible(false)
end

daygiftCloseButton.onMouseClick = function ()
	DayGift:setVisible(false)
	-- dayGiftButton:setVisible(true)
end



-- local function CountdownDayGift(func)
--     local time = 0
--     local totalTime = timeToDaygift * 20
--     World.Timer(1, function()
--         time = time + 1
--         refreshProcessDaygift(totalTime, time)
-- 		dayGiftTime:setText(60 - (math.floor(time/20)))
--         if time >= totalTime then
--             -- print("Success")
-- 			dayGiftButton:setVisible(true)
--             func()
--             return
--         end
--         return 1
--     end)
-- end

claimButton.onMouseClick = function()
	-- DayGift:setVisible(false)
	-- dayGiftButton:setVisible(false)
	-- dayGiftProgressBar:setVisible(true)
	-- dayGiftTime:setVisible(true)
	PackageHandlers.sendClientHandler("ClaimAward")
			claimButton:setVisible(false)
			claimImage:setVisible(true)
			effectGift:setVisible(false) --Không có quà
			ImageGift:setVisible(true)
			-- CountdownDayGift(function()
			-- dayGiftButton:setVisible(true)
			-- dayGiftProgressBar:setVisible(false)
			-- dayGiftTime:setVisible(false)
    -- end)
end


-- PackageHandlers.registerClientHandler("StackFull", function()
-- 	print("StackFull")
-- 	claimButton:setVisible(false)
-- end)

-- PackageHandlers.registerClientHandler("StackOpen", function()
-- 	print("StackFull")
-- 	claimButton:setVisible(true)
-- end)


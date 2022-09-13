print("startup ui")
local loadingProgressBar = self:child("ProgressBar")
local timeToUpgrade = 10

local function refreshProcess(totalTime, curTime)
    local progress = curTime / totalTime
    loadingProgressBar:setProperty("CurrentProgress", progress)
end
local function Countdown(func)
    local time = 0
    local totalTime = timeToUpgrade * 20
    World.Timer(1, function()
        time = time + 1
        refreshProcess(totalTime, time)
        if time >= totalTime then
            print("Success")
            func()
            return
        end
        return 1
    end)
end

Countdown(function()
    World.Timer(10, function()
        UI:closeWindow(self)
    end)
end)
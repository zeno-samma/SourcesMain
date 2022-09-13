local giftDataTb = {
    {type = "Item", itemPath = "myplugin/WoodenP", sum = 1},
    {type = "Money", moneyType = "Gold", sum = 300},
    {type = "Money", moneyType = "Diamond", sum = 100},
    {type = "Money", moneyType = "Gold", sum = 600},
    {type = "Money", moneyType = "Diamond", sum = 200},
    {type = "Money", moneyType = "Gold", sum = 900},
    {type = "Pet", petName = "Yasuo", sum = 1}
}

local petConfig =  require "script_server.PetCfg"
petConfig = petConfig.petConfig


local function judgeCanGetGift(dateData)
    local time1 = tonumber(dateData.lastDay)
    local time2 = tonumber(Lib.getYearDayStr(os.time()))
    return time1 == time2                                --Incity means that no reward has been received today
end

local function judgeCanUpdateWeekData(dateData, player)
    local time1 = tonumber(dateData.curtWeek)
    local time2 = tonumber(Lib.getYearWeekStr(os.time()))
    if time1 ~= time2 then                              --The incupities indicate that the date data is reset for different weeks
        dateData.curtWeek = time2                       --The number of update weeks
        dateData.totalLoginCount = 0                    --Reset the number of login days
        player:setValue("DateData", dateData)            --Update data
    end
end

local function UpdateDateData(dateData, player)
    dateData.totalLoginCount = dateData.totalLoginCount + 1  --The cumulative number of login days plus one
    dateData.lastDay = Lib.getYearDayStr(os.time())          --Record today"s date
    player:setValue("DateData", dateData)                    --Save the data
end

----Get player data, update the seven-day login interface
PackageHandlers.registerServerHandler("getSevenLoginData", function(player, packet)
    local dateData = player:getValue("DateData")
    PackageHandlers.sendServerHandler(player, "UI_openSevenLoginWnd", { index = dateData.totalLoginCount, haveGot = judgeCanGetGift(dateData) })
end)

--Give out rewards
PackageHandlers.registerServerHandler("giveLoginGift", function(player, packet)
    local dateData = player:getValue("DateData")

    local totalLoginCount = tonumber(dateData.totalLoginCount) + 1
    local curDayGift = giftDataTb[totalLoginCount]

    if curDayGift.type == "Item" then
        player:addItem(curDayGift.itemPath, curDayGift.sum)
    elseif curDayGift.type == "Money" then
        local money = player:getValue("Money")
        money[curDayGift.moneyType] = money[curDayGift.moneyType] + curDayGift.sum
        player:setValue("Money", money)
    elseif curDayGift.type == "Pet" then
        Lib.emitEvent("Add Pet to Player", {player, petConfig[curDayGift.petName], curDayGift.sum})
    end
    UpdateDateData(dateData, player)
end)

local function checkDateData(player)
    -- print("Vao day")
    local dateData = player:getValue("DateData")
    if not judgeCanGetGift(dateData) then
        judgeCanUpdateWeekData(dateData, player)                              -- Check to see if it is the same week
        PackageHandlers.sendServerHandler(player, "showSevenLoginRedDot")     -- Turn on the red dot prompt
    end
end

Trigger.addHandler(Entity.GetCfg("myplugin/player1"), "ENTITY_ENTER", function(context)
    checkDateData(context.obj1)
end)

-- When the computing server is turned on, the deadline of today is used to refresh the seven-day login prompt
local hour = tonumber(os.date("%H"))
local minute = tonumber(os.date("%M"))
local second = tonumber(os.date("%S"))

local dayEndTime = (24 - hour - 1) * 60 * 60 * 20 + (60 - minute - 1) * 60 * 20 + (60 - second) * 20

World.Timer(dayEndTime, function()
    for i, player in pairs(Game.GetAllPlayers()) do
        checkDateData(player)
        print("Da check")
    end
    return 24 * 60 * 60 * 20
end)

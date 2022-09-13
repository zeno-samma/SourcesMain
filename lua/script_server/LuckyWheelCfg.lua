

local _price = {
    Diamond = 1000,
    GCube = 10
}
local _diamondPrize = {
    {"Turtle", 20},--39
    {"BlueFish", 18},--44
    {"GreenFish", 16},--46
    {"UglyDuckling", 13},--62
    {"Flamingo", 10},--63
    {"GoldFish", 8},--67
    {"Ducky", 7},--68
    {"Shark", 4},--110
    {"Kraken", 3},--175
    {"Hydra", 1}--215
}

local _GCubePrize = {
    {"Gecko", 18},--96
    {"Elephant", 16},--97
    {"HappyRock", 14},--120
    {"Bat", 12},--120
    {"OrangeGecko", 11},--150
    {"Yasuo", 9},--175
    {"Griffin", 7},--200
    {"Bull", 6},--200
    {"Imotuus", 4},--300
    {"Motuus", 3}--440
}
local _StagesPrize = {
    Diamond = {
        ["10"] = "Turtle",
        ["20"] = "BlueFish",
        ["30"] = "GreenFish",
        ["40"] = "UglyDuckling",
        ["50"] = "Flamingo",
        ["60"] = "GoldFish",
        ["70"] = "Ducky",
        ["80"] = "Shark",
        ["90"] = "Kraken",
        ["100"] = "Hydra"
    },
    GCube = {
        ["10"] = "Gecko",
        ["20"] = "Elephant",
        ["30"] = "HappyRock",
        ["40"] = "Bat",
        ["50"] = "OrangeGecko",
        ["60"] = "Yasuo",
        ["70"] = "Griffin",
        ["80"] = "Bull",
        ["90"] = "Imotuus",
        ["100"] = "Motuus"
    }
}


return {
    Diamond = _diamondPrize,
    GCube = _GCubePrize,
    Price = _price,
    StagesPrize = _StagesPrize
}
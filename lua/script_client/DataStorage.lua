
local player, invent, playerCfg


PackageHandlers.registerClientHandler("Inventory Updated", function(_player, data)
    print("Inventory Updated...!")
    invent = data
    player = _player
    print(invent[1].Label)
end)



PackageHandlers.registerClientHandler("PlayerCfg Updated", function(_player, _playerCfg)
	playerCfg = _playerCfg
    PackageHandlers.sendOtherClient(_player.platformUserId, "Return Inventory Data", {invent, playerCfg})
end)



PackageHandlers.registerClientHandler("Get Inventory Data", function(_player)
    World.Timer(10, function ()
        PackageHandlers.sendOtherClient(_player.platformUserId, "Return Inventory Data", {invent, playerCfg})
    end)
end)
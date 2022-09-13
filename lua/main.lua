if World.isClient then
	require "script_client.main"
	else
	require "script_server.main"
	
	local money = {  ---- 5 don vi tien te
		["Gold"] = 1,
		["Diamond"] = 1,
		["FantasyCoin"] = 0,
		["TechCoin"] = 0,
		["PixelCoin"] = 0
	}
	
	local gateFee = { -- phi tele 
		map001 = 0,
		Zone1 = 0,
		Zone2 = 75000,
		Zone3 = 400000,
		Zone4 = 1250000,
		Zone5 = 5500000,
		Zone6 = 16500000,
		Zone7 = 50000000
	}
	
	local gateFeeDiamond = { --phi tele kim cuong
		map001 = 25000,
		Zone1 = 6000,
		Zone2 = 7500,
		Zone3 = 10000,
		Zone4 = 12500,
		Zone5 = 12500,
		Zone6 = 12500,
		Zone7 = 12500
	}
	
	local inventoryNode = { --inventory
		Name = "",
		Label = "",
		Slot = 0,
		Level = 1,
		Atk = 0.01,
		HP = 20,
		Buff = {},
		Skill = {
			"SkillPet"
		},
		Count = 0
	}
	
	local inventory = {}
	-------Gamepass----
	-- buff:
	-- speed: x2
	-- money: x2
	-- dame pet: x2
	-- orther:
	-- 4 more pet summon
	-- infinite pet summon
	-- inventory slot: +25
	-- 5 eggs mode
	-- free teleport
	-- vip
	-------------
	local playerCfg = {
		LoginFirst = 0,
		MaxSlot = 25,
		MaxPet = 2,
		FreeTeleport = false,
		Vip = false,
		MaxSpeed = 0,
		TimerSpeed = 0,
		MoneyBuff = 1,
		TimerMoney = 0,
		DamePetBuff = 1,
		TimerDamePetBuff = 0,
		FiveEggsMode = false,
		AtkDefault = 1,
		AtkPickaxe = 0,
		TimerAtkPick = 0,
		CurSkin = {def = "def"},
		SkinsInventory = {},
		TotalWheel = {
			Diamond = {
				Value = 0,
				ClaimStages = 0
			},
			GCube = {
				Value = 0,
				ClaimStages = 0
			}
		}
	}
	local firstLogin = {
		first = 0,
		Day = 0,
		Count = 0,
		Flag = 0,
		curStep = 0,
		Use_Max = 7 
	}-------
	local dayGift = {
		Day = 0,
		Count = 0,
		Last = 0,
		Flag = 0,
		Relay_Time = 5*60*20,--5 phut
		Timer = 0,--5 phut
		Use_Max = 5
	}
	
	Entity.addValueDef("FirstLogin", firstLogin, true, true, true, false)
	Entity.addValueFunc("FirstLogin", function(entity)
		local firstLogin = entity:getValue("FirstLogin")
		PackageHandlers.sendServerHandler(entity, "Tutorial Updated", firstLogin)
		-- print(Lib.pv(firstLogin))
	end)
	
	Entity.addValueDef("DayGift", dayGift, true, true, true, false)
	Entity.addValueFunc("DayGift", function(entity)
		local dayGift = entity:getValue("DayGift")
		PackageHandlers.sendServerHandler(entity, "DayGift Updated", dayGift)
		-- print(Lib.pv(dayGift))
	end)
	
	Entity.addValueDef("Money", money, true, true, true, false)
	Entity.addValueFunc("Money", function(entity)
		local money = entity:getValue("Money")
		PackageHandlers.sendServerHandler(entity, "Money Updated", money)
	end)
	
	Entity.addValueDef("Gate Fee", gateFee, true, true, true, false)
	Entity.addValueFunc("Gate Fee", function(entity)
		local gateFee = entity:getValue("Gate Fee")
		print("Gate Fee Updated")
		PackageHandlers.sendServerHandler(entity, "Gate Fee Updated", gateFee)
		-- print(Lib.pv(gateFee))
	end)
	
	Entity.addValueDef("Gate Fee Diamond", gateFeeDiamond, true, true, true, false)
	Entity.addValueFunc("Gate Fee Diamond", function(entity)
		local gateFeeDiamond = entity:getValue("Gate Fee Diamond")
		print("Gate Fee Diamond Updated")
		PackageHandlers.sendServerHandler(entity, "Gate Fee Diamond Updated", gateFee)
		-- print(Lib.pv(gateFeeDiamond))
	end)
	
	Entity.addValueDef("Inventory", inventory, true, true, true, false)
	Entity.addValueFunc("Inventory", function(entity)
		local inventory = entity:getValue("Inventory")
		print("Inventory Updated")
		local playerCfg = entity:getValue("PlayerCfg")
		entity:setValue("PlayerCfg", playerCfg)
		--print(Lib.pv(inventory))
		print("PlayerCfg Updated")
		PackageHandlers.sendServerHandler(entity, "PlayerCfg Updated", playerCfg)
		PackageHandlers.sendServerHandler(entity, "Inventory Updated", inventory)
		-- print(Lib.pv(inventory))
	end)

	Entity.addValueDef("PlayerCfg", playerCfg, true, true, true, false) 
	Entity.addValueFunc("PlayerCfg", function(entity)
		local playerCfg = entity:getValue("PlayerCfg")
		print("PlayerCfg Updated")
		PackageHandlers.sendServerHandler(entity, "PlayerCfg Updated", playerCfg)
		entity:setValue("Money", entity:getValue("Money"))
		-- print(Lib.pv(playerCfg))
	end)
	
	
	
	--Entity.addValueDef("Can Revive", true, true, true, true, false)
	Entity.addValueFunc("Can Revive", function(entity)
		local canRevive = entity:getValue("Can Revive")
		print("Can Revive Updated" .. entity.objID)
		Lib.emitEvent("Can Revive Updated" .. entity.objID, canRevive)
	end)
	
	end
	require "script_common.main"
	-- Debug
	-- Lib.subscribeEvent(Event.EVENT_FINISH_DEAL_GAME_INFO, function(...)
	--     DebugDraw.Instance():setDrawColliderEnabled(true)
	-- end)

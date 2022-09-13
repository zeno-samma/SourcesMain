print("startup ui")

local fiveEggs = self:child("fiveEggsMode")
local oneEggs = self:child("oneEggsMode")
local moreEggs = self:child("moreEggsMode")
local closeButton = self:child("CloseButton")
local name = self:child("Name")
local actorWindowone = self:child("ActorWindow")
local ActorWindows ={}
for i = 1, 5 do
	ActorWindows[i] = self:child("ActorWindow"..i)
end
local function clickSound()
	local TdAudioEngine = TdAudioEngine.Instance()
	local soundID = TdAudioEngine.Instance():play2dSound("asset/Sound/receive.mp3", false)
	TdAudioEngine:setSoundsVolume(soundID,0.4)
end
PackageHandlers.registerClientHandler("Return Pet Received", function(player, pack)
	UI:closeWindow("Gui/InventoryUI")
	local fiveEggsMode = pack[2]
	local moreEggsMode = pack[3]
	-- print("Debug")
	-- clickSound()
	-- print(Lib.pv(pack[1]))
	if not fiveEggsMode and not moreEggsMode then
		oneEggs:setVisible(true)
		local petData = pack[1][1]
		name:setText(name:getText() .. petData.Name)
		actorWindowone:setActorName(petData.Name.. ".actor")
		-- actorWindowone:setSkillName("idle4")
	elseif fiveEggsMode then
		fiveEggs:setVisible(true)
		for i=1,5 do
			ActorWindows[i]:setActorName(pack[1][i].Name..".actor")
		end
		name:setVisible(false)
	elseif moreEggsMode then
		moreEggs:setVisible(true)
		local gridView = self:child("GridView")
		local gridViewItem = gridView:child("Image")
		local AW = gridViewItem:child("ActorWindow")
		print(Lib.pv(pack[1][1]))
		AW:setActorName(pack[1][1].Name..".actor")
		for i = 2, #pack[1] do
			local newGI = gridViewItem:clone()
			gridView:addChild(newGI)
			local newAW = newGI:child("ActorWindow")
			newAW:setActorName(pack[1][i].Name..".actor")
		end
		name:setVisible(false)
	end
end)

closeButton.onMouseClick = function ()
	UI:closeWindow(self)
	UI:closeWindow("Gui/InventoryUI")
	UI:openWindow("Gui/InventoryUI")
	PackageHandlers.sendClientHandler("Step11")
end
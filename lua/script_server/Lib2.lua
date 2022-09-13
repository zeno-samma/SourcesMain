
local _createNPCWithinTheRegion=function(minPos,maxPos,minCount,maxCount,namePlugin,nameAl,mapName,owner,level)
  local num=math.random(minCount,maxCount)
  local _map = World.CurWorld:getMap(mapName)
  local miPos = {}
  local maPos = {}
  if minPos.x>maxPos.x then
    miPos.x=maxPos.x
    maPos.x=minPos.x
  else
    miPos.x=minPos.x
    maPos.x=maxPos.x
  end
  if minPos.y>maxPos.y then
    miPos.y=maxPos.y
    maPos.y=minPos.y
  else
    miPos.y=minPos.y
    maPos.y=maxPos.y
  end
  if minPos.z>maxPos.z then
    miPos.z=maxPos.z
    maPos.z=minPos.z
  else
    miPos.z=minPos.z
    maPos.z=maxPos.z
  end
  while num>0 do
    local location=Vector3.new(math.random(minPos.x,maxPos.x), math.random(minPos.y,maxPos.y), math.random(minPos.z,maxPos.z))
    local createParams = {cfgName = namePlugin, pos = location, map = _map}
    local entity = EntityServer.Create(createParams)
    if nameAl~="" then
      entity:startAI()
      local id=owner:addPet(entity)
    end
    num=num-1
  end
end

return {
  createNPCWithinTheRegion = _createNPCWithinTheRegion
}
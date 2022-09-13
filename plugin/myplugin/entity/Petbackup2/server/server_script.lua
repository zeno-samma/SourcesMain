print('sandbox:hello word')
Trigger.RegisterHandler(this:cfg(), "ENTITY_CLICK", function(context)
    local target = context.obj1                                            --Get the clicked entity
    local from = context.obj2                                              --Get the entity that initiated the click
    target:takeDamage(10, from, false, '')                                 --The clicked entity is injured
   -- World.CurWorld.SystemNotice(1, from.name..' click '..target.name, 40)  --Broadcast
    local pos = target:getPosition() 
    print(pos)
end)
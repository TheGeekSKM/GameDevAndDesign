function SetData(_spawnables, _avoidables, _num, _layer = "Interactables")
{
    var spawnables = _spawnables;
    var avoidables = _avoidables;
    var numToSpawn = _num;
    
    for (var i = 0; i < numToSpawn; i++)
    {
        var spawnable = ChooseFromArray(spawnables);
        var spawnX, spawnY, avoidable;
        
        do {
            spawnX = irandom_range(0, room_width);
            spawnY = irandom_range(0, room_height);
            avoidable = instance_position(spawnX, spawnY, avoidables);
        } until (avoidable == noone);
        
        instance_create_layer(spawnX, spawnY, _layer, spawnable);
    
    }    
}


var spawnables = [obj_Zombie];
var avoidables = [obj_Wall, obj_BASE_Entity, obj_Blocker];
var numToSpawn = numToSpawnPerWave;
    
for (var i = 0; i < numToSpawn; i++)
{
    var spawnable = ChooseFromArray(spawnables);
    var spawnX, spawnY, avoidable;
    
    do {
        spawnX = irandom_range(0, room_width);
        spawnY = irandom_range(0, room_height);
        avoidable = instance_position(spawnX, spawnY, avoidables);
    } until (avoidable == noone);
    
    instance_create_layer(spawnX, spawnY, "Entities", spawnable);

}

if (canSummon) alarm[0] = irandom_range(5, 20) * 30;
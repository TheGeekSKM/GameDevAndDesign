if (global.pause) return;
spawnCounter++;
if (spawnCounter >= (spawnInterval * 60))
{
    instance_create_layer(x, y, "cars", obj_carDown);
    spawnCounter = 0;
    spawnInterval = irandom_range(1, 5);
}
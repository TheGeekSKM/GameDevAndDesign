spawnCounter++;
if (spawnCounter >= (spawnInterval * 60))
{
    instance_create_layer(x, y, "cars", obj_carUP);
    spawnCounter = 0;
    spawnInterval = irandom_range(1, 3);
}
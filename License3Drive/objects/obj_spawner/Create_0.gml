x1 = x;
y1 = y;
x2 = sprite_width;
y2 = sprite_height;

repeat (numToSpawn)
{
    var xPos = irandom_range(x1, x2);
    var yPos = irandom_range(y1, y2);
    
    instance_create_layer(xPos, yPos, spawnLayer, object);
}
for (var i = 0; i < numToSpawn; i++)
{
    var xPos = random_range(x - (sprite_width / 2), x + (sprite_width / 2));
    var yPos = random_range(y - (sprite_height / 2), y + (sprite_height / 2));
    
    instance_create_layer(xPos, yPos, "Items", obj_computerPart);
}

Subscribe("EnemyKilled", function(_true) {
    if (random(100) < 40)
    {
        var xPos = random_range(x - (sprite_width / 2), x + (sprite_width / 2));
        var yPos = random_range(y - (sprite_height / 2), y + (sprite_height / 2));
            
        instance_create_layer(xPos, yPos, "NPCs", obj_Enemy_Chase);        
    }
});
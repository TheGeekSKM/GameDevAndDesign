if (global.pause) return;

nextY = y - (sprite_height * 2.5) - yModifier;
nextX = x - (sprite_width / 2);

if (checkForCars) CheckForCarInFront();
if (checkForPlayer) CheckForPlayerInFront(); 
    


var otherCar = collision_rectangle(x - (sprite_width / 2), y - (sprite_height / 2), x + (sprite_width / 2), y + (sprite_height / 2), obj_car, false, true)
if (otherCar)
{
    instance_destroy(otherCar);
    instance_create_layer(x, y, "Collectibles", obj_gear);
    instance_create_layer(x, y, "Oil", obj_oilSpill);
    Raise("Crash", new Vector2(x, y));
    instance_destroy();
}

y += carSpeed;

if (y < (0 - sprite_height)) instance_destroy();
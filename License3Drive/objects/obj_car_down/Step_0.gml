if (global.pause) return;

nextX = x - (sprite_width / 2)
nextY = y + (sprite_height * 2.5) + yModifier;

if (checkForCars) CheckForCarInFront();
if (checkForPlayer) CheckForPlayerInFront();    

var otherCar = collision_rectangle(x - (sprite_width / 2) - 2, y - (sprite_height / 2) - 2, x + (sprite_width / 2) + 2, y + (sprite_height / 2) + 2, obj_car, true, true)
if (otherCar)
{
    instance_destroy(otherCar);
    instance_create_layer(x, y, "Collectibles", obj_gear);
    Raise("Crash", new Vector2(x, y));
    instance_destroy();
}

y += carSpeed;

if (y > (room_height + sprite_height)) instance_destroy();
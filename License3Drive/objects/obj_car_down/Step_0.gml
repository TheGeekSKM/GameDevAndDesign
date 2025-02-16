nextX = x - (sprite_width / 2)
nextY = y + (sprite_height * 2.5) + yModifier;

if (checkForCars) CheckForCarInFront();
if (checkForPlayer) CheckForPlayerInFront();    

var otherCar = collision_rectangle(x - (sprite_width / 2), y - (sprite_height / 2), x + (sprite_width / 2), y + (sprite_height / 2), obj_car, false, true)
if (otherCar)
{
    //spawn explosion and car parts
}

y += carSpeed;

if (y > (room_height + sprite_height)) instance_destroy();
nextY = y - (sprite_height / 2) - (sprite_height * 2);
nextX = x - (sprite_width / 2);

if (checkForCars) CheckForCarInFront();
if (checkForPlayer) CheckForPlayerInFront(); 

var otherCar = collision_rectangle(x - (sprite_width / 2), y - (sprite_height / 2), x + (sprite_width / 2), y + (sprite_height / 2), obj_car, false, true)
if (otherCar)
{
    //spawn explosion and car parts
}

y += carSpeed;

if (y < (0 - sprite_height)) instance_destroy();
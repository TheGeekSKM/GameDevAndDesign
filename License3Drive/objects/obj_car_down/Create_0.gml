carDirection = CarDirection.Down;
carSpeed = 0;
carSpeed = irandom_range(2, 4);
if (carDirection == CarDirection.Up) carSpeed *= -1;

defaultSpeed = carSpeed;

checkForCars = random_range(0, 100) < 10 ? false : true;
checkForPlayer = random_range(0, 100) < 30 ? false : true;
stopSpeed = 0.2;

image_blend = make_color_hsv(irandom(255), 75, irandom_range(100, 255));

nextX = 0;
nextY = 0;

yModifier = irandom_range(0, 10);
frontCar = noone;

function CheckForCarInFront()
{
    frontCar = collision_rectangle(x + (sprite_width / 2), y + (sprite_width / 2), nextX, nextY, obj_car, false, true);
    if (frontCar) 
    {
        carSpeed = frontCar.carSpeed;
    } 
    else 
    {
        carSpeed = lerp(carSpeed, defaultSpeed, 0.2);
    }
}

function CheckForPlayerInFront()
{
    var player = collision_rectangle(x + (sprite_width / 2), y - (sprite_width / 2), nextX, nextY, obj_player, false, true);
    if (player) 
    {
        carSpeed = lerp(carSpeed, 0, stopSpeed);
    } 
    else 
    {
        carSpeed = lerp(carSpeed, defaultSpeed, 0.2);
    }    
}
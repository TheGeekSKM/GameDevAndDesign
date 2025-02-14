carDirection = CarDirection.Up;
carSpeed = 0;
carSpeed = irandom_range(2, 4);
if (carDirection == CarDirection.Up) carSpeed *= -1;

defaultSpeed = carSpeed;

checkForCars = random(100) < 20 ? false : true;
checkForPlayer = random(100) < 70 ? false : true;
stopSpeed = random_range(0.09, 0.1);

image_blend = make_color_hsv(irandom(255), 75, irandom_range(100, 255));

nextX = 0;
nextY = 0;

function CheckForCarInFront()
{
    var frontCar = collision_rectangle(x + (sprite_width / 2), y - (sprite_width / 2), nextX, nextY, obj_car, false, true);
    if (frontCar) 
    {
        carSpeed = lerp(carSpeed, frontCar.carSpeed, stopSpeed);
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
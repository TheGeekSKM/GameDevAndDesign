var next_x = (x + lengthdir_x(carSpeed, direction)) * 2;
var next_y = (y + lengthdir_y(carSpeed, direction)) * 2;

if (collision_rectangle(x, y, next_x, next_y, obj_car, false, true)) 
{
    carSpeed = lerp(carSpeed, 0, 0.5);
} 
else 
{
    carSpeed = lerp(carSpeed, defaultSpeed, 0.2);
}

if (collision_rectangle(x - (sprite_width / 2), y - (sprite_height / 2), x + (sprite_width / 2), y + (sprite_height / 2), obj_car, false, true))
{
    //spawn explosion and car parts
}

y += carSpeed;

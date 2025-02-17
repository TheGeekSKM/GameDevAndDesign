if (global.pause) 
{
    image_speed = 0;
    return;
}

if (!canWalk) return;
var distToGo = point_distance(x, y, newPos.x, newPos.y);
var dir = point_direction(x, y, newPos.x, newPos.y);

if (distToGo > npcSpeed)
{
    walking = true;
    image_speed = 1;
    move_and_collide(lengthdir_x(npcSpeed, dir), lengthdir_y(npcSpeed, dir), [obj_wall]);
    image_angle = dir;
}
else {
    newPos.x = x;
    newPos.y = y;
    walking = false;
    image_speed = 0;
    image_index = 0;
    canWalk = false;
    
    timeToPickNewPoint = irandom_range(180, 360);
    alarm[1] = (random(100) >= 30 ? timeToPickNewPoint : random(25));
}

if (point_distance(x, y, obj_player.x, obj_player.y) < 10 and input_check_pressed("accept"))
{
    canWalk = true;
}
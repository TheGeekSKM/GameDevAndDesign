stats.Step();
entityHealth.Step();
inventory.Step();
stamina.Step();
entityData.Step();
hunger.Step();

controller.Step();

if (canMove)
{
    if (wanderRandomly)
    {
        wanderCounter++;
        if (wanderCounter >= wanderTime)
        {
            wanderCounter = 0;
            wanderTime = irandom_range(60, 600);
            wanderDirection = point_direction(x, y, irandom_range(0, room_width), irandom_range(0, room_height));
        }
        move_towards_point(x + lengthdir_x(1, wanderDirection), 
            y + lengthdir_y(1, wanderDirection), stats.GetMoveSpeed()
        );
    }
    else if (chase)
    {
        move_towards_point(prey.x, prey.y, stats.GetMoveSpeed());
    }
}
else {
    speed = 0;
}

if (canAttack)
{
    var dir = point_direction(x, y, prey.x, prey.y);
    image_angle = dir;
    var pointInFront = new Vector2(x + lengthdir_x(5, dir), y + lengthdir_y(5, dir));
    
    if (point_distance(x, y, prey.x, prey.y) <= attackRange)
    {
        attack.Step(pointInFront, image_angle);
    }
}
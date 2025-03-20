stats.Step();
entityHealth.Step();
inventory.Step();
stamina.Step();
entityData.Step();
hunger.Step();

if (canMove)
{
    if (wanderRandomly)
    {
        wanderDirection = 0;
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
    else if (moveTowardsFoodSource)
    {
        move_towards_point(targetFoodSource.x, targetFoodSource.y, stats.GetMoveSpeed());
    }
    else if (fleeing)
    {
        move_towards_point(fleePosition.x, fleePosition.y, stats.GetMoveSpeed() * 1.5);
    }
}
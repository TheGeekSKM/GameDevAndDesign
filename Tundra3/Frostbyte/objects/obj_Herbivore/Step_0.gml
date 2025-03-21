stats.Step();
entityHealth.Step();
inventory.Step();
stamina.Step();
entityData.Step();
hunger.Step();
if (entityHealth.IsDead()) instance_destroy();

controller.Step();

if (canMove)
{
    if (wanderRandomly)
    {
        wanderCounter++;
        if (wanderCounter >= wanderTime)
        {
            xMove = ChooseFromArray([-1, 1]) * entityData.moveSpeed;
            yMove = ChooseFromArray([-1, 1]) * entityData.moveSpeed;

            wanderCounter = 0;
        }
        image_angle = point_direction(x, y, x + xMove, y + yMove);
        move_and_collide(xMove, yMove, collisionObjects);
    }
    else if (moveTowardsFoodSource)
    {
        image_angle = point_direction(x, y, targetFoodSource.x, targetFoodSource.y);
        xMove = lengthdir_x(stats.GetMoveSpeed(), image_angle);
        yMove = lengthdir_y(stats.GetMoveSpeed(), image_angle);
        move_and_collide(xMove, yMove, collisionObjects);
    }
    else if (fleeing)
    {
        image_angle = point_direction(x, y, fleePosition.x, fleePosition.y);
        xMove = lengthdir_x(stats.GetMoveSpeed() * 1.5, image_angle);
        yMove = lengthdir_y(stats.GetMoveSpeed() * 1.5, image_angle);
        move_and_collide(xMove, yMove, collisionObjects);
    }
}


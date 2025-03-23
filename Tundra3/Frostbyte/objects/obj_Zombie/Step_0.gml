stats.Step();
entityHealth.Step();
inventory.Step();
stamina.Step();
entityData.Step();
hunger.Step();

if (entityHealth.IsDead()) 
{
    delete stats;
    delete inventory;
    delete entityHealth;
    delete stamina;
    delete hunger;
    delete temperature;
    delete attack;
    delete entityData;
    instance_destroy();
}

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
    else if (chase)
    {
        image_angle = point_direction(x, y, prey.x, prey.y);
        xMove = lengthdir_x(stats.GetMoveSpeed(), image_angle);
        yMove = lengthdir_y(stats.GetMoveSpeed(), image_angle);
        move_and_collide(xMove, yMove, collisionObjects);
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
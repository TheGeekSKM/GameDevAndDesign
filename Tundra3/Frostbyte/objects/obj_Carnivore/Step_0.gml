stats.Step();
entityHealth.Step();
inventory.Step();
stamina.Step();
entityData.Step();
hunger.Step();

controller.Step();

attacker = entityHealth.recentAttacker;



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
    else if (chaseTarget)
    {
        image_angle = point_direction(x, y, preyTarget.x, preyTarget.y);
        move_towards_point(preyTarget.x, preyTarget.y, stats.GetMoveSpeed());
    }
    else if (fleeing)
    { 
        image_angle = point_direction(x, y, fleePosition.x, fleePosition.y);
        move_towards_point(fleePosition.x, fleePosition.y, stats.GetMoveSpeed());
    }

    x = clamp(x, 0, room_width);
    y = clamp(y, 0, room_height);
}
else {
    speed = 0;
}

if (canAttack)
{
    var attackerDist = instance_exists(attacker) ? point_distance(x, y, attacker.x, attacker.y) : 10000000;
    var preyDist = instance_exists(preyTarget) ? point_distance(x, y, preyTarget.x, preyTarget.y) : 10000000;

    var target = attackerDist < preyDist ? attacker : preyTarget;
    var dir = point_direction(x, y, target.x, target.y);
    var pointInFront = new Vector2(x + lengthdir_x(5, image_angle), y + lengthdir_y(5, image_angle));
    
    if (point_distance(x, y, target.x, target.y) <= attackRange)
    {
        attack.Step(pointInFront, image_angle);
    }
}


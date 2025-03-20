event_inherited();
controller.Step();

if (canMove)
{
    if (fleeing)
    {
        var attacker = entityHealth.recentAttacker;
        if (attacker != noone)
        {
            var direction = 180 + point_direction(x, y, attacker.x, attacker.y);
            var speed = entityData.moveSpeed;
            var motion_x = lengthdir_x(speed, direction);
            var motion_y = lengthdir_y(speed, direction);

            move_and_collide(motion_x, motion_y, collisionObjects, 4, 0, 0, speed, -1);
        }
    }
    else if (walkToStartingPos)
    {
        var direction = point_direction(x, y, startingPos.x, startingPos.y);
        var speed = entityData.moveSpeed;
        var motion_x = lengthdir_x(speed, direction);
        var motion_y = lengthdir_y(speed, direction);

        move_and_collide(motion_x, motion_y, collisionObjects, 4, 0, 0, speed, -1);
    }
}

if (canAttack)
{
    var attacker = entityHealth.recentAttacker;
    if (attacker != noone)
    {
        var direction = point_direction(x, y, attacker.x, attacker.y);
        image_angle = direction;
        var pointInFront = new Vector2(x + lengthdir_x(5, direction), y + lengthdir_y(5, direction));
        attack.Step(pointInFront, image_angle);
    }
}
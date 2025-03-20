event_inherited();
controller.Step();

if (canMove)
{
    if (fleeing)
    {
        var attacker = entityHealth.recentAttacker;
        if (attacker != noone)
        {
            var dir = 180 + point_direction(x, y, attacker.x, attacker.y);
            var spd = entityData.moveSpeed;
            var motion_x = lengthdir_x(spd, dir);
            var motion_y = lengthdir_y(spd, dir);

            move_and_collide(motion_x, motion_y, collisionObjects, 4, 0, 0, spd, -1);
        }
    }
    else if (walkToStartingPos)
    {
        var dir = point_direction(x, y, startingPos.x, startingPos.y);
        var spd = entityData.moveSpeed;
        var motion_x = lengthdir_x(spd, dir);
        var motion_y = lengthdir_y(spd, dir);

        move_and_collide(motion_x, motion_y, collisionObjects, 4, 0, 0, spd, -1);
    }
}

if (canAttack)
{
    var attacker = entityHealth.recentAttacker;
    if (attacker != noone)
    {
        var dir = point_direction(x, y, attacker.x, attacker.y);
        image_angle = dir;
        var pointInFront = new Vector2(x + lengthdir_x(5, dir), y + lengthdir_y(5, dir));
        attack.Step(pointInFront, image_angle);
    }
}
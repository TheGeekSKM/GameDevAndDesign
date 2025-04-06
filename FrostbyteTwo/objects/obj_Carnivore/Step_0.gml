// Inherit the parent event
event_inherited();
stats.Step();
entityHealth.Step();

if (entityHealth.IsDead()) instance_destroy(id);

inventory.Step();
stamina.Step();
entityData.Step();
temperature.Step();
hunger.Step();

controller.Step();

attacker = entityHealth.recentAttacker;

if (instance_place(x, y, obj_ItemReq_SiliconDeposit)) entityData.slowed = true;
else entityData.slowed = false;

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
        if (!instance_exists(preyTarget)) { return;}
        image_angle = point_direction(x, y, preyTarget.x, preyTarget.y);
        xMove = lengthdir_x(stats.GetMoveSpeed(inventory.currentWeight), image_angle);
        yMove = lengthdir_y(stats.GetMoveSpeed(inventory.currentWeight), image_angle);
        move_and_collide(xMove, yMove, collisionObjects);
    }
    else if (fleeing)
    { 
        image_angle = point_direction(x, y, fleePosition.x, fleePosition.y);
        xMove = lengthdir_x(stats.GetMoveSpeed(inventory.currentWeight), image_angle);
        yMove = lengthdir_y(stats.GetMoveSpeed(inventory.currentWeight), image_angle);
        move_and_collide(xMove, yMove, collisionObjects);
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
    var pointInFront = new Vector2(x + lengthdir_x(10, image_angle), y + lengthdir_y(10, image_angle));
    
    if (point_distance(x, y, target.x, target.y) <= attackRange)
    {
        attack.Step(pointInFront, image_angle);
    }
}

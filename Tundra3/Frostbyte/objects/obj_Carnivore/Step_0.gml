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
        var xMove = 0;
        var yMove = 0;
        wanderCounter++;
        
        if (wanderCounter >= wanderTime)
        {
            var dir = point_direction(x, y, irandom_range(0, room_width), irandom_range(0, room_height));
            var distance = irandom_range(50, 100);
            var xMove = lengthdir_x(distance, dir);
            var yMove = lengthdir_y(distance, dir);
            wanderCounter = 0;
        }
        
        move_towards_point(x + xMove, y + yMove, stats.GetMoveSpeed());
    }
    else if (chaseTarget)
    {
        move_towards_point(preyTarget.x, preyTarget.y, stats.GetMoveSpeed());
    }
    else if (fleeing)
    {
        move_towards_point(fleePosition.x, fleePosition.y, stats.GetMoveSpeed());
    }
}

if (canAttack)
{
    var attackerDist = instance_exists(attacker) ? point_distance(x, y, attacker.x, attacker.y) : 10000000;
    var preyDist = instance_exists(preyTarget) ? point_distance(x, y, preyTarget.x, preyTarget.y) : 10000000;

    var target = attackerDist < preyDist ? attacker : preyTarget;
    
    var dir = point_direction(x, y, target.x, target.y);
    image_angle = dir;
    var pointInFront = new Vector2(x + lengthdir_x(5, dir), y + lengthdir_y(5, dir));
    
    if (point_distance(x, y, target.x, target.y) <= attackRange)
    {
        attack.Step(pointInFront, image_angle);
    }
}


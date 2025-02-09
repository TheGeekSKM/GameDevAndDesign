if (global.pause)
{
    image_speed = 0;
    return;
}


switch (currentState)
{
    case NPCState.Idle:
        //stand still
        image_speed = 0;
        image_index = 0;
        
        var player = collision_circle(x, y, 20, obj_player, false, false);
    
        if (player) RotateToPlayer();
           
        walkCounter++;
        if (walkCounter >= (currentStandTime * 60))
        {
            walkCounter = 0;
            currentStandTime = irandom_range(walkRange.x, walkRange.y);
            currentState = NPCState.WantToWalk;
        }
        //if player is within radius, face player
        //if random chance is > walk threshold, change to walk state
        break;
    case NPCState.WantToWalk:
        targetPos = bounds.GenerateRandomPoint();
        currentState = NPCState.Walking;
        //populates targetPos with a point within bounds
        //once targetPos != currentPos
        break;
    case NPCState.Walking:

        walkingCounter++;
        var distToGo = point_distance(x, y, targetPos.x, targetPos.y);
        image_speed = 1.0;
        var dir = point_direction(x, y, targetPos.x, targetPos.y);
        
        if (distToGo > spd)
        {
            move_and_collide(lengthdir_x(spd, dir), lengthdir_y(spd, dir), [obj_block]);
        }
        else 
        {
            targetPos.x = x;
            targetPos.y = y;
            
            walkingCounter = 0;
            currentState = NPCState.Idle;
        }
        
        image_angle = ClampAngle90(dir);
        
        if (walkCounter > (walkTime * 60))
        {
            targetPos.x = x;
            targetPos.y = y;
            
            walkingCounter = 0;
            currentState = NPCState.Idle;
        }
        break;
        
}


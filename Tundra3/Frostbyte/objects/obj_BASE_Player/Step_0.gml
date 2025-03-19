controller.Step()

stats.Step();
entityHealth.Step();
inventory.Step();
stamina.Step();
entityData.Step();
hunger.Step();

if (canAttack) 
{
    target.Step();
    image_angle = point_direction(x, y, target.x, target.y);
    var pointInFront = new Vector2(x + lengthdir_x(5, image_angle), y + lengthdir_y(5, image_angle));
    attack.Step(pointInFront, image_angle);
}

if (canMove)
{
    var up = global.vars.InputManager.IsDown(PlayerIndex, ActionType.Up);
    var down = global.vars.InputManager.IsDown(PlayerIndex, ActionType.Down);
    var left = global.vars.InputManager.IsDown(PlayerIndex, ActionType.Left);
    var right = global.vars.InputManager.IsDown(PlayerIndex, ActionType.Right);

    var moveX = (right - left) * entityData.moveSpeed;
    var moveY = (down - up) * entityData.moveSpeed;

    if (moveX != 0) moveY = 0;
    if (moveY != 0) moveX = 0;
        
    if (moveX>0) image_angle = 0;
    if (moveX<0) image_angle = 180; 
    if (moveY>0) image_angle = 270;
    if (moveY<0) image_angle = 90;
        
    if (moveX != 0 or moveY != 0) {
        image_speed = entityData.moveSpeed / 3;
    } 
    else 
    {
        doOnce = false;
        image_index = 1;
        image_speed = 0;
    }
        
    move_and_collide(moveX, moveY, collisionObjects, 4, 0, 0, entityData.moveSpeed, -1);
}

// echo($"Player #{PlayerIndex + 1}'s State: {controller.stateMachine.get_current_state()}", true);


stats.Step();
entityHealth.Step();
stamina.Step();
hunger.Step();
temperature.Step();
entityData.Step();

if (entityHealth.IsDead()) 
{
    echo("huh?")
    Transition(rmLose, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide);
    instance_destroy();
}
if (paused) return;

var menu = global.vars.InputManager.IsPressed(PlayerIndex, ActionType.Menu);
if (menu)
{
    Raise("PauseOpen", PlayerIndex);
}

controller.Step()

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

    var moveX = (right - left) * entityData.moveSpeed * 1.5;
    var moveY = (down - up) * entityData.moveSpeed * 1.5;

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
        
    move_and_collide(moveX, moveY, collisionObjects, 4, 0, 0, entityData.moveSpeed * 1.5, -1);
}

if (!ds_exists(tempInteractableList, ds_type_list)) 
{
    return;
}

ds_list_clear(tempInteractableList);
collision_circle_list(x, y, interactionRange, [obj_BASE_Interactable, obj_NPC], false, true, tempInteractableList, false);

for (var i = 0; i < ds_list_size(tempInteractableList); i += 1) 
{
    var interactable = ds_list_find_value(tempInteractableList, i);
    if (instance_exists(interactable))
    {
        if (interactable.playerInRange == noone)
        {
            interactable.playerInRange = id;
            array_push(interactableArray, interactable);
        }
    }   
}

for (var i = array_length(interactableArray) - 1; i >= 0; i--) 
{
    var interactable = interactableArray[i];
    if (!instance_exists(interactable))
    {
        array_delete(interactableArray, i, 1);
        break;
    }

    var dist = point_distance(x, y, interactable.x, interactable.y);
    if (dist > interactionRange) 
    {
        interactable.playerInRange = noone;
        array_delete(interactableArray, i, 1);
    }
}

if (global.vars.InputManager.IsPressed(PlayerIndex, ActionType.Action1)) 
{
    for (var i = 0; i < array_length(interactableArray); i += 1) 
    {
        interactableArray[i].OnInteract();    
    }
}

if (keyboard_check_pressed(vk_period)) CameraShake(PlayerIndex, 50, 50);

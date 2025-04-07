// Inherit the parent event
event_inherited();
if (global.vars.pause) 
{
    speed = 0;
    image_index = 1;
    image_speed = 0;
    return;
}

if (keyboard_check_pressed(vk_backspace))
{
    obj_camera.AddCameraShake(10);
}

stats.Step();
entityHealth.Step();

if (entityHealth.IsDead()) Transition(rmLose, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide)

inventory.Step();
stamina.Step();
entityData.Step();
temperature.Step();
hunger.Step();

var moveSpeed = entityData.moveSpeed * 2;
    
var pd = point_direction(x, y, obj_Target.x, obj_Target.y);
var dd = angle_difference(image_angle, pd);
image_angle -= min(abs(dd), 10) * sign(dd);
        
if (distance_to_point(obj_Target.x,obj_Target.y) > 64)
{
    move_towards_point(obj_Target.x,obj_Target.y,moveSpeed);	
}
else if (distance_to_point(obj_Target.x,obj_Target.y) > 3)
{
    move_towards_point(obj_Target.x,obj_Target.y,moveSpeed / 2);
}
else 
{
    speed = 0;
}

if (place_meeting(x+hspeed,y+vspeed,collisionObjects))
{
    speed = 0;		
    obj_Target.x = x;
    obj_Target.y = y;
}

if (speed == 0)
{
    image_speed = 0;
    image_index = 1;    
}
else 
{
    image_speed = speed / 3;
}

rightClickHold = mouse_check_button(mb_right) and !instance_exists(obj_Mouse.currentInteractable);
if (rightClickHold)
{
    image_angle = point_direction(x, y, mouse_x, mouse_y);
    var pointInFront = new Vector2(x + lengthdir_x(5, image_angle), y + lengthdir_y(5, image_angle));
    attack.Step(pointInFront, image_angle);
    
}


if (instance_exists(currentCollectible) || currentCollectible != noone)
{
    var dist = point_distance(x, y, currentCollectible.x, currentCollectible.y);
    if (dist < currentCollectible.InteractionRange)
    {
        currentCollectible.Collect(id);
        currentCollectible = noone;
    }
}

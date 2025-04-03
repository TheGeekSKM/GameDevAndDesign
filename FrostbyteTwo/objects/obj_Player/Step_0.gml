// Inherit the parent event
event_inherited();

get_game_camera(0).set_position(x, y);

stats.Step();
entityHealth.Step();
inventory.Step();
stamina.Step();
entityData.Step();
hunger.Step();

controller.Step();

var moveSpeed = entityData.moveSpeed;

var leftClick = mouse_check_button_pressed(mb_right) and obj_Mouse.currentInteractable == noone;
    
var pd = point_direction(x, y, obj_Target.x, obj_Target.y);
var dd = angle_difference(image_angle, pd);
image_angle -= min(abs(dd), 10) * sign(dd);
        
if (distance_to_point(obj_Target.x,obj_Target.y) > 64)
{
    move_towards_point(obj_Target.x,obj_Target.y,moveSpeed);	
}
else if (distance_to_point(obj_Target.x,obj_Target.y) > 20)
{
    move_towards_point(obj_Target.x,obj_Target.y,moveSpeed / 2);
}
else if (distance_to_point(obj_Target.x,obj_Target.y) >= 5)
{
    move_towards_point(obj_Target.x,obj_Target.y,moveSpeed / 4);
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

rightClickHold = mouse_check_button(mb_right) and obj_Mouse.currentInteractable == noone;
if (rightClickHold)
{
    echo("ree?")
    image_angle = point_direction(x, y, mouse_x, mouse_y);
}


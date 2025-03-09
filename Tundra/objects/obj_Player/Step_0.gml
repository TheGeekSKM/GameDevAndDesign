var leftClick = mouse_check_button_pressed(mb_right);

var pd = point_direction(x, y, obj_target.x, obj_target.y);
var dd = angle_difference(image_angle, pd);
image_angle -= min(abs(dd), 10) * sign(dd);
        
if (distance_to_point(obj_target.x,obj_target.y) > entityMovementData.distances.x)
{
    move_towards_point(obj_target.x,obj_target.y,entityMovementData.speeds.x);	
}
else if (distance_to_point(obj_target.x,obj_target.y) > entityMovementData.distances.y)
{
    move_towards_point(obj_target.x,obj_target.y,entityMovementData.speeds.y);
}
else if (distance_to_point(obj_target.x,obj_target.y) >= entityMovementData.distances.z)
{
    move_towards_point(obj_target.x,obj_target.y,entityMovementData.speeds.z);
}
else 
{
    speed = 0;
}

if (place_meeting(x+hspeed,y+vspeed,collidables))
{
    speed = 0;		
    obj_target.x = x;
    obj_target.y = y;
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

if (keyboard_check_pressed(ord("D"))) 
{
    healthSystem.TakeDamage(2);
}
if (global.vars.pause) 
{
    image_alpha = 0;
    return;
}

if (mouse_check_button(mb_left))
{
    if (instance_exists(obj_Mouse.currentInteractable)) return;
    echo("test")
    x=mouse_x;
    y=mouse_y;
    
    image_xscale =1.5;
    image_yscale =1.5;
    image_alpha = 1;
}

else
{
    image_xscale =1;
    image_yscale =1;
}

if (distance_to_object(obj_Player)>=drawDist)
{
    canDraw = true;
}
else 
{
    canDraw = false;
}
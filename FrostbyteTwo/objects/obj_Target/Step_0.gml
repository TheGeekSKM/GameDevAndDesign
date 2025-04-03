if (obj_Mouse.currentInteractable != noone) { image_alpha = 0; return; }

if (mouse_check_button(mb_left))
{
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
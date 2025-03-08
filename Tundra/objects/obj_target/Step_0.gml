if (obj_mouse.currentState != MouseState.Normal) { image_alpha = 0; return; }

if   (mouse_check_button(mb_left))
    {
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

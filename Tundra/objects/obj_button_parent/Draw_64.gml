// Inherit the parent event
event_inherited();

switch (currentState)
{
    case ButtonState.Idle: 
        scribble(Text)
            .align(fa_center, fa_middle)
            .blend(c_black, 1)
            .transform(1, 1, image_angle)
            .sdf_outline(c_black, 0)            
            .draw(x, y);
    break;
    
    case ButtonState.Hovered: 
        scribble(Text)
            .align(fa_center, fa_middle)
            .blend(global.mainColor, 1)
            .sdf_outline(c_black, 2)
            .transform(1, 1, image_angle)
            .sdf_shadow(c_black, 0.65, 0, 0, 3)
            .draw(x, y + 4);
    break;
    
    case ButtonState.Clicked: 
        scribble(Text)
            .align(fa_center, fa_middle)
            .blend(global.mainColor, 1)
            .sdf_outline(c_black, 2)   
            .transform(1, 1, image_angle)
            .sdf_shadow(c_black, 0.65, 0, 0, 3)
            .draw(x, y + 4);    
    break;
}

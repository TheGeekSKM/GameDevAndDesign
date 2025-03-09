draw_self();

switch (currentState)
{
    case ButtonState.Idle: 
        scribble(Text)
            .align(fa_center, fa_middle)
            .starting_format("VCR_OSD_Mono", c_black)
            .blend(c_black, 1)
            .draw(x, y);    
    break;
    
    case ButtonState.Hover: 
        scribble(Text)
            .align(fa_center, fa_middle)
            .starting_format("VCR_OSD_Mono", c_black)
            .blend(c_black, 1)
            .draw(x, y + 10);    
    break;
    
    case ButtonState.Click: 
        scribble(Text)
            .align(fa_center, fa_middle)
            .starting_format("VCR_OSD_Mono", global.vars.mainColor)
            .blend(global.vars.mainColorLight, 1)
            .sdf_outline(c_black, 3)
            .draw(x, y + 10);    
    break;
}




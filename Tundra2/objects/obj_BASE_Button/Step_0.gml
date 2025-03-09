// Inherit the parent event
event_inherited();

switch (currentState)
{
    case ButtonState.Idle: 
        image_blend = merge_color(image_blend, c_white, 0.1);
    break;
    
    case ButtonState.Hover: 
        image_blend = merge_color(image_blend, global.vars.mainColorLight, 0.1);
    break;
    
    case ButtonState.Click: 
        image_blend = global.vars.mainColor;   
    break;
}
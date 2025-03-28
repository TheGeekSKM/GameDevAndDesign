// Inherit the parent event
event_inherited();

switch (currentState)
{
    case ButtonState.Idle: 
        image_index = 0;
        image_blend = merge_color(image_blend, c_white, 0.1);
    break;
    
    case ButtonState.Hover: 
        image_index = 1;
        image_blend = merge_color(image_blend, global.vars.mainColorLight, 0.1);
    break;
    
    case ButtonState.Click: 
        image_index = 1;        
        image_blend = global.vars.mainColor;   
    break;
}

if (obj_mouse.currentInteractable != id) currentState = ButtonState.Idle;
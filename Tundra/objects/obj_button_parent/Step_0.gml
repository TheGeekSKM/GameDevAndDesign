var mousePos = new Vector2(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0))
if (position_meeting(mousePos.x, mousePos.y, id) and currentState == ButtonState.Idle) currentState = ButtonState.Hovered;
else if (!position_meeting(mousePos.x, mousePos.y, id)) currentState = ButtonState.Idle;
    
switch (currentState)
{
    case ButtonState.Idle: 
        image_blend = merge_color(image_blend, IdleColor, 0.1);
        image_xscale = lerp(image_xscale, startingXScale, 0.2);
        image_yscale = lerp(image_yscale, startingYScale, 0.2);
    break;
    case ButtonState.Hovered: 
        image_blend = merge_color(image_blend, HoverColor, 0.1);
        image_xscale = lerp(image_xscale, startingXScale * hoverScaleMultiplier, 0.2);
        image_yscale = lerp(image_yscale, startingYScale * hoverScaleMultiplier, 0.2);    
    break;
    case ButtonState.Clicked: 
        image_blend = ClickColor;
        image_xscale = lerp(image_xscale, startingXScale * hoverScaleMultiplier, 0.2);
        image_yscale = lerp(image_yscale, startingYScale * hoverScaleMultiplier, 0.2);    
    break;
}
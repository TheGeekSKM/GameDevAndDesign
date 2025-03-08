var mousePos = new Vector2(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0))
if (position_meeting(mousePos.x, mousePos.y, id) and currentState == ButtonState.Idle) {
    currentState = ButtonState.Hovered;
    Raise("MouseOver", MouseState.Point);
}
else if (!position_meeting(mousePos.x, mousePos.y, id) and currentState != ButtonState.Idle) {
    currentState = ButtonState.Idle;
    Raise("MouseLeave", id);     
}
    
switch (currentState)
{
    case ButtonState.Idle: 
        image_blend = merge_color(image_blend, IdleColor, 0.1);
        image_xscale = startingXScale;
        image_yscale = startingYScale;
        image_index = 0;
    break;
    case ButtonState.Hovered: 
        image_blend = merge_color(image_blend, HoverColor, 0.1);
        image_xscale = startingXScale * hoverScaleMultiplier;
        image_yscale = startingYScale * hoverScaleMultiplier;
        image_index = 1;        
    break;
    case ButtonState.Clicked: 
        image_blend = ClickColor;
        image_xscale = startingXScale * hoverScaleMultiplier;
        image_yscale = startingYScale * hoverScaleMultiplier; 
        image_index = 1;       
    break;
}
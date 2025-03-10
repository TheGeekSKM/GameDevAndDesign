// Inherit the parent event
event_inherited();

if (dragging)
{
    x = device_mouse_x_to_gui(0) + mouseOffsetX;
    y = device_mouse_y_to_gui(0) + mouseOffsetY;
}


dragRect = [x - (sprite_width / 2), y - (sprite_height / 2),
    x + (sprite_width / 2), y - (sprite_height / 2) + 35];

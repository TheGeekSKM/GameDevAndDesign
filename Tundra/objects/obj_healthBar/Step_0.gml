if (point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), x, y, x + sprite_width, y + sprite_height)) 
{ 
    if (!hoverCounter < 60) { hoverCounter++; } 
    if (!hovered) {
        hovered = true;
        obj_mouse.IsOverUI = true;
    }
}
else
{ 
    hoverCounter = 0; 
    if (hovered) {
        hovered = false;
        obj_mouse.IsOverUI = false;
    }
}

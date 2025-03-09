if (point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), x, y, x + sprite_width, y + sprite_height)) 
{ 
    if (!hoverCounter < 60) { hoverCounter++; } 
    if (!hovered) {
        hovered = true;
        Raise("MouseOverUI", id);
    }
}
else
{ 
    hoverCounter = 0; 
    if (hovered) {
        hovered = false;
        Raise("MouseNotOverUI", id);
    }
}

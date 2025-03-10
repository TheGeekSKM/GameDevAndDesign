// Inherit the parent event
event_inherited();
depth = -1;


dragRect = [x - (sprite_width / 2), y - (sprite_height / 2),
    x + (sprite_width / 2), y - (sprite_height / 2) + 35];


function OnMouseLeftClick()
{
    if (point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), dragRect[0], dragRect[1], dragRect[2], dragRect[3]))
    {
        MenuManager.StartDragging();
    }
}

function OnMouseLeftClickRelease()
{
    MenuManager.StopDragging();
}
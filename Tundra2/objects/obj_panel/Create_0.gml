// Inherit the parent event
event_inherited();
depth = -1;

dragRect = [x - (sprite_width / 2), y - (sprite_height / 2),
    x + (sprite_width / 2), y - (sprite_height / 2) + 35];

dragging = false;
mouseOffsetX = 0;
mouseOffsetY = 0;

function OnMouseLeftClick()
{
    if (point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), dragRect[0], dragRect[1], dragRect[2], dragRect[3]))
    {
        var mx = device_mouse_x_to_gui(0);
        var my = device_mouse_y_to_gui(0);
        
        dragging = true;
        
        mouseOffsetX = x - mx;
        mouseOffsetY = y - my;
    }
}

function OnMouseLeftClickRelease()
{
    if (dragging) dragging = false;    
}
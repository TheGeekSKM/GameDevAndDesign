event_inherited();
topLeftX = x - (sprite_width / 2)
topLeftY = y - (sprite_height / 2);

if (y < 0)
{
    spawned = true;
}

if (spawned)
{
    y = lerp(y, (room_height / 2), 0.1)
    if (abs(y - (room_height / 2)) < 10)
    {
        y = room_height / 2;
        spawned = false;
    }
    else
    {
        return;
    }
}

if (dragging)
{
    x = guiMouseX + mouseOffsetX;
    y = guiMouseY + mouseOffsetY;
}

if (disableChoices) return;

if (currentState != ButtonState.Hover) return;

//accept button
if (point_in_rectangle(guiMouseX, guiMouseY, 
    topLeftX + 31, topLeftY + 254, 
    topLeftX + 31 + 87, topLeftY + 254 + 43))
{
    mouseInAccept = true;
}

// reject button
else if (point_in_rectangle(guiMouseX, guiMouseY, 
    topLeftX + 130, topLeftY + 254, 
    topLeftX + 130 + 87, topLeftY + 254 + 43))
{
    mouseInReject = true;
}
else {
    mouseInAccept = false;
    mouseInReject = false;
}

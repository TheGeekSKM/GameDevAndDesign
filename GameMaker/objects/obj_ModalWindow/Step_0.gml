// Inherit the parent event
event_inherited();

topLeftX = x - (sprite_width / 2);
topLeftY = y - (sprite_height / 2);

topRightX = x + (sprite_width / 2);
topRightY = y - (sprite_height / 2);

if (dragging)
{
    x = guiMouseX - xOffset;
    y = guiMouseY - yOffset;
}

if (point_in_rectangle(guiMouseX, guiMouseY, topRightX - 31, topRightY + 1, topRightX - 1, topRightY + 31))
{
    mouseOverClose = true;
}
else {
    mouseOverClose = false;
}

if (keyboard_check_released(vk_enter) && registerEnter)
{
    if (onCloseCallback != undefined) onCloseCallback();
    instance_destroy();
}
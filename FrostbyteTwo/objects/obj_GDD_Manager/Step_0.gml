// Inherit the parent event
event_inherited();

if (!open and point_in_rectangle(guiMouseX, guiMouseY, 368, 0, 368 + 64, 33))
{
    echo("ree?")
    OpenMenu();
}

if (open and (abs(guiMouseY - obj_Panel_DropDown.y) > 75))
{
    CloseMenu();
}


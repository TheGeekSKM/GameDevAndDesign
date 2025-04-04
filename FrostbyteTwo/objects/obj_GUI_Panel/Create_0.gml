// Inherit the parent event
event_inherited();

dragRect = new Rectangle(x - (sprite_width / 2), y - (sprite_height / 2), x + (sprite_width / 2), y + (sprite_height / 2));


function OnMouseLeftClick() 
{
    if Draggable and obj_Mouse.currentInteractable == id
    {
        if (instance_exists(MenuManager)) MenuManager.StartDragging();
    }
}

function OnMouseLeftClickRelease()
{
    if (instance_exists(MenuManager)) MenuManager.StopDragging();
}




// Inherit the parent event
event_inherited();

dragRect = new Rectangle(x - (sprite_width / 2), y - (sprite_height / 2), x + (sprite_width / 2), y + (sprite_height / 2));


function OnMouseLeftClick() 
{
    if Draggable and obj_Mouse.currentInteractable == id
    {
        MenuManager.StartDragging();
    }
}

function OnMouseLeftClickRelease()
{
    MenuManager.StopDragging();
}




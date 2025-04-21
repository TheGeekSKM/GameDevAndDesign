// Inherit the parent event
event_inherited();

function OnMouseLeftClickRelease()
{
    layer_set_visible("Page1", false);
    layer_set_visible("Page2", true);
    
    with (obj_TIF_GameName)
    {
        EnterPressed();
    }
}
// Inherit the parent event
event_inherited();

enabled = true;

function OnMouseLeftClickRelease()
{
    layer_set_visible("Page1", false);
    layer_set_visible("Page2", true);
    
    with (obj_TIF_GameName)
    {
        EnterPressed();
    }
    
    Raise("Page2", id);
}

Subscribe("Page2", function() {
    enabled = false;    
})

Subscribe("Page1", function() {
    enabled = true;    
})
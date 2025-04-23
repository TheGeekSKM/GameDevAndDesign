// Inherit the parent event
event_inherited();
enabled = false;

function OnMouseLeftClickRelease()
{
    layer_set_visible("Page1", true);
    layer_set_visible("Page2", false);
    
    Raise("Page1", id);
}

Subscribe("Page2", function() {
    enabled = true;    
})

Subscribe("Page1", function() {
    enabled = false;    
})
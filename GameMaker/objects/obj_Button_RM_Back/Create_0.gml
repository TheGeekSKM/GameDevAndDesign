// Inherit the parent event
event_inherited();

function OnMouseLeftClickRelease()
{
    layer_set_visible("Page1", true);
    layer_set_visible("Page2", false);
}
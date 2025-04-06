// Inherit the parent event
event_inherited();

function OnMouseLeftClick()
{
    Raise("CraftingOpen", id);
}
// Inherit the parent event
event_inherited();

function OnClickEnd()
{
    Raise("InventoryOpen", 1);
}
// Inherit the parent event
event_inherited();


if (inventorySystemRef != undefined && slotIndex != -1)
{
    equippedItem = inventorySystemRef.GetSlot(slotIndex).item[$ "equipped"]
}
else
{
    equippedItem = false;
}

if (equippedItem)
{
    sprite_index = spr_equippedInventorySlot169;
}
else
{
    sprite_index = spr_inventorySlot150;
}

if (currentState == ButtonState.Hover) image_index = 1;
else image_index = 0;
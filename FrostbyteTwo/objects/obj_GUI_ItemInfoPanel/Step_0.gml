// Inherit the parent event
event_inherited();

if (!instance_exists(currentSlotObject) || currentSlotObject.inventorySystemRef.GetSlot(currentSlotObject.slotIndex).quantity <= 0)
{
    HideMenu();
}
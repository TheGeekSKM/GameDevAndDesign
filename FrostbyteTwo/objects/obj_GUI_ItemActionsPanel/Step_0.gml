// Inherit the parent event
event_inherited();

if (instance_exists(useButton)) useButton.SetPosition(x, topLeft.y + 48);
if (instance_exists(infoButton)) infoButton.SetPosition(x, topLeft.y + 92);
if (instance_exists(dropButton)) dropButton.SetPosition(x, topLeft.y + 136);
    
if (!instance_exists(currentSlotObject) || currentSlotObject.inventorySystemRef.GetSlot(currentSlotObject.slotIndex).quantity <= 0)
{
    HideMenu();
}
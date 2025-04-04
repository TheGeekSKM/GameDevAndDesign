if (global.dragData.isDragging == false) return; // No drag operation in progress

var targetSlotInstance = instance_position(guiMouseX, guiMouseY, obj_InventorySlotDisplay);

if (instance_exists(targetSlotInstance)) {
    AttemptDrop(targetSlotInstance.inventorySystemRef, targetSlotInstance.slotIndex);    
} 
else 
{
    StopDrag(); // Stop dragging if no valid target slot is found
}

if (global.dragData.isDragging) {
    StopDrag(); // Stop dragging if the item was successfully dropped
}
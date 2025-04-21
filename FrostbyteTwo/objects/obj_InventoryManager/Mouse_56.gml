if (global.dragData.isDragging == false) return; // No drag operation in progress

var targetSlotInstance = instance_position(guiMouseX, guiMouseY, obj_InventorySlotDisplay);

if (instance_exists(targetSlotInstance)) {
    AttemptDrop(targetSlotInstance.inventorySystemRef, targetSlotInstance.slotIndex);    
} 
else 
{ 
    var sourceInventory = global.dragData.sourceInventory;
    var sourceIndex = global.dragData.sourceSlotIndex;
    var draggedItem = global.dragData.item;
    var draggedQuantity = global.dragData.quantity;
    // check to see if the mouse is currently hovering over an interactable
    if (instance_exists(obj_Mouse.currentInteractable))
    {
        
        if (variable_instance_exists(obj_Mouse.currentInteractable, "itemReciever") && is_struct(obj_Mouse.currentInteractable.itemReciever))
        {
            var itemReciever = obj_Mouse.currentInteractable.itemReciever;
            var acceptsItem = itemReciever[$ "DropItem"](draggedItem, draggedQuantity);
    
            if (acceptsItem)
            {
                sourceInventory.SetSlot(sourceIndex, undefined, 0); // Remove item from source slot
            }
            else
            {
                // Call the StopDrag function to reset the drag state
                StopDrag();
                return false; // No drop action performed
            }
        }
		else if (variable_instance_exists(obj_Mouse.currentInteractable, "inventorySystemRef"))
		{
			var targetInventory = obj_Mouse.currentInteractable.inventorySystemRef;
			targetInventory.AddItem(draggedItem, draggedQuantity);
			StopDrag();
			return true;
		}
        else
        {
            // Call the StopDrag function to reset the drag state
            StopDrag();
            return false; // No drop action performed
        }
    }
    else
    {
        // if not, create an obj_BASE_Collectible and Initialize() to spawn that object
        var collectible = instance_create_layer(mouse_x, mouse_y, "Collectibles", obj_BASE_Collectible);
        collectible.Initialize(draggedItem, 1);
        //sourceInventory.SetSlot(sourceIndex, undefined, 0);
        
        sourceInventory.DropItemByIndex(sourceIndex, 1);
         
        StopDrag();
        return false;
    }
}

if (global.dragData.isDragging) {
    StopDrag(); // Stop dragging if the item was successfully dropped
}
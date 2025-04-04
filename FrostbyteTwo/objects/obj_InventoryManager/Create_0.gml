global.dragData = {
    isDragging: false,
    sourceInventory : undefined,
    sourceSlotIndex : -1,
    item : undefined,
    quantity : 0,
    mouseOffsetX : 0,
    mouseOffsetY : 0,
};

depth = -1000;

global.InventoryManager = id;

global.activeInventories = [];

function StartDrag(_inventory, _slotIndex, _mouseX, _mouseY, _slotX, _slotY)
{
    var slot = _inventory.GetSlot(_slotIndex);

    if (slot == undefined || slot.item == undefined || slot.quantity <= 0) return false;

    global.dragData.isDragging = true;
    global.dragData.sourceInventory = _inventory;
    global.dragData.sourceSlotIndex = _slotIndex;
    global.dragData.item = slot.item;
    global.dragData.quantity = slot.quantity;
    global.dragData.mouseOffsetX = _slotX - _mouseX;
    global.dragData.mouseOffsetY = _slotY - _mouseY;

    return true;
}

function StopDrag()
{
    global.dragData.isDragging = false;
    global.dragData.sourceInventory = undefined;
    global.dragData.sourceSlotIndex = -1;
    global.dragData.item = undefined;
    global.dragData.quantity = 0;
}

function AttemptDrop(_targetInventory, _targetSlotIndex)
{
    if (global.dragData.isDragging == false) return false;

    var sourceInventory = global.dragData.sourceInventory;
    var sourceIndex = global.dragData.sourceSlotIndex;
    var draggedItem = global.dragData.item;
    var draggedQuantity = global.dragData.quantity;

    if (_targetInventory == sourceInventory && _targetSlotIndex == sourceIndex) 
    {
        StopDrag();
        return false; // No drop action performed
    }

    var targetSlot = _targetInventory.GetSlot(_targetSlotIndex);

    // Case 1: Target slot is empty
    if (targetSlot == undefined || targetSlot.item == undefined || targetSlot.quantity <= 0) 
    {
        _targetInventory.SetSlot(_targetSlotIndex, draggedItem, draggedQuantity);
        sourceInventory.SetSlot(sourceIndex, undefined, 0); // Remove item from source slot
        show_debug_message($"Dropped {draggedQuantity}x{draggedItem.name} onto empty slot {_targetSlotIndex}");
    }

    // Case 2: Target slot has the same item
    else if (targetSlot.item[$ "name"] == draggedItem[$ "name"]) 
    {
        var maxStack = draggedItem.stackSize;
        var canAdd = maxStack - targetSlot.quantity;

        if (canAdd > 0)
        {
            var amountToAdd = min(draggedQuantity, canAdd);
            _targetInventory.SetSlot(_targetSlotIndex, draggedItem, targetSlot.quantity + amountToAdd);
            sourceInventory.SetSlot(sourceIndex, draggedItem, draggedQuantity - amountToAdd); // Update source slot quantity

            if (sourceInventory.GetSlot(sourceIndex).quantity <= 0)
            {
                sourceInventory.SetSlot(sourceIndex, undefined, 0); // Remove item from source slot if quantity is 0
            }
        }
        else
        {
            var tempTargetItem = targetSlot.item;
            var tempTargetQuantity = targetSlot.quantity;
            _targetInventory.SetSlot(_targetSlotIndex, draggedItem, draggedQuantity);
            sourceInventory.SetSlot(sourceIndex, tempTargetItem, tempTargetQuantity); // Update source slot quantity
        }
    }

    // Case 3: Target slot has a different item
    else 
    {
        var tempTargetItem = targetSlot.item;
        var tempTargetQuantity = targetSlot.quantity;
        _targetInventory.SetSlot(_targetSlotIndex, draggedItem, draggedQuantity);
        sourceInventory.SetSlot(sourceIndex, tempTargetItem, tempTargetQuantity); // Update source slot quantity
        show_debug_message($"Swapped {draggedQuantity}x{draggedItem.name} with {tempTargetQuantity}x{tempTargetItem.name} in slot {_targetSlotIndex}");
    }

    StopDrag(); // Stop dragging after drop action
    return true; // Drop action performed
}

function SpawnInventoryWindow(_inventory, _x, _y, _title = "Inventory")
{
    var win = FindWindowForInventory(_inventory);
    if (!instance_exists(obj_GUI_InventoryWindow) || win == noone)
    {
        var newWin = instance_create_layer(_x, _y, "GUI", obj_GUI_InventoryWindow);
        newWin.inventorySystemRef = _inventory;
        newWin.x = _x;
        newWin.y = _y;
        newWin.PanelTitle = _title;
    }
    else
    {
        win.x = _x;
        win.y = _y;
        win.visible = true;
        win.PanelTitle = _title;
        win.inventorySystemRef = _inventory;
        win.RebuildSlotDisplays(); // Rebuild the slot displays to reflect the current inventory state
    }
}

function FindWindowForInventory(_inventory)
{
    for (var i = 0; i < array_length(global.activeInventories); i += 1) {
        var win = global.activeInventories[i];
        if (win.inventorySystemRef.owner == _inventory.owner) {
            return win;
        }
    }
    return noone;
}
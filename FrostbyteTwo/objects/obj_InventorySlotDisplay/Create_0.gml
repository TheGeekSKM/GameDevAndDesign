// Inherit the parent event
event_inherited();

inventorySystemRef = undefined;
slotIndex = -1;
parentWindow = noone;
slotSize = 32;
equippedItem = false;


isHovered = false;

function OnMouseLeftClick()
{
    if (!global.dragData.isDragging)
    {
        if (instance_exists(global.InventoryManager))
        {
            global.InventoryManager.StartDrag
            (
                inventorySystemRef, 
                slotIndex, 
                guiMouseX, 
                guiMouseY, 
                x + (sprite_width / 2), 
                y + (sprite_height / 2)
            );
        }
    }
}

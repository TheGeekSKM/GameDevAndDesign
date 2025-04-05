// Inherit the parent event
event_inherited();

inventorySystemRef = undefined;
displayIndex = 0;
slotDisplayInstances = [];
width = 200;
height = 150;
visible = true;

slotsPerRow = 5;
slotSize = 32;
slotPadding = 4;
startXOffset = 10;
startYOffset = 40;

dragging = false;
windowMouseOffset = new Vector2(0, 0);

lastKnownSlotCount = -1;
topLeft = new Vector2(x - width / 2, y - height / 2);

closeButton = noone;

function RebuildSlotDisplays()
{
    if (inventorySystemRef == undefined) return;

    // 1. Clear the old slot displays
    for (var i = 0; i < array_length(slotDisplayInstances); i += 1) {
        var instID = slotDisplayInstances[i];
        if (instance_exists(instID)) {
            instance_destroy(instID);
        }
    }
    
    if (instance_exists(closeButton)) instance_destroy(closeButton);

    // 2. Get the current state from the inventory system
    var currentSlots = inventorySystemRef.allItems;
    var numSlots = array_length(currentSlots);
    lastKnownSlotCount = numSlots;

    // 3. Calculate positioning variables
    var displayStartX = topLeft.x + startXOffset;
    var displayStartY = topLeft.y + startYOffset;

    // 4. Create the new slot displays instances
    for (var i = 0; i < numSlots; i += 1) {
        var col = i mod slotsPerRow;
        var row = floor(i / slotsPerRow);

        var slotX = displayStartX + (col * (slotSize + slotPadding));
        var slotY = displayStartY + (row * (slotSize + slotPadding));

        var slotInst = instance_create_layer(slotX, slotY, "GUI", obj_InventorySlotDisplay);
        slotInst.inventorySystemRef = inventorySystemRef;
        slotInst.slotIndex = i;
        slotInst.parentWindow = id;
        slotInst.slotSize = slotSize;

        array_push(slotDisplayInstances, slotInst);
    }

    // 5. Update the window size based on the number of slots
    var rowsNeeded = max(1, ceil(numSlots / slotsPerRow));
    var colsUsed = min(numSlots, slotsPerRow);
    height = (rowsNeeded * (slotSize + slotPadding)) + startYOffset + 18;
    width = (colsUsed * (slotSize + slotPadding)) + startXOffset + 18;

    width = max(width, 200); // Ensure a minimum width
    height = max(height, 150); // Ensure a minimum height
    
    image_xscale = width / sprite_get_width(sprite_index);
    image_yscale = height / sprite_get_height(sprite_index);
    
    // 6. Create Close Button
    closeButton = instance_create_depth(topLeft.x + sprite_width, topLeft.y, id.depth - 10, obj_Button_InventoryWindowClose);
    closeButton.depth = id.depth - 10;
    closeButton.Text = "X";
    closeButton.AddCallback(function () {
        array_delete(global.activeInventories, displayIndex, 1);
        for (var i = 0; i < array_length(slotDisplayInstances); i++) {
            var inst = slotDisplayInstances[i];
            instance_destroy(inst);
        }
        instance_destroy(closeButton);
        global.vars.ResumeGame(global.vars.Player);
        instance_destroy();
    });
}

function OnMouseLeftClick()
{
    dragging = true;
    windowMouseOffset.x = guiMouseX - x;
    windowMouseOffset.y = guiMouseY - y;
}

function OnMouseLeftClickRelease()
{
    dragging = false;
}

displayIndex = array_length(global.activeInventories);
array_push(global.activeInventories, id);


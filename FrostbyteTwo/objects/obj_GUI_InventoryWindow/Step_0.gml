// Inherit the parent event
event_inherited();

topLeft = new Vector2(x - width / 2, y - height / 2);
if (!visible || inventorySystemRef == undefined) return;

if (inventorySystemRef == undefined)
{
    lastKnownSlotCount = -1;
    return;
}

var currentSlotCount = array_length(inventorySystemRef.allItems);
if (currentSlotCount != lastKnownSlotCount)
{
    RebuildSlotDisplays();
}

for (var i = 0; i < array_length(slotDisplayInstances); i += 1) {
    // move the slot display instances to follow the position of the window
    var instID = slotDisplayInstances[i];
    if (instance_exists(instID)) {
        instID.x = topLeft.x + startXOffset + ((i mod slotsPerRow) * (slotSize + slotPadding));
        instID.y = topLeft.y + startYOffset + (floor(i / slotsPerRow) * (slotSize + slotPadding));
    }
}

closeButton.x = topLeft.x + sprite_width;
closeButton.y = topLeft.y;

if (dragging)
{
    var mousePosX = guiMouseX - windowMouseOffset.x;
    var mousePosY = guiMouseY - windowMouseOffset.y;
    x = mousePosX;
    y = mousePosY;
}

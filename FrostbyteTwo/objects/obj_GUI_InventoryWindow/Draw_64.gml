// Inherit the parent event
event_inherited();

if (!visible) return;
if (inventorySystemRef == undefined) return;
if (lastKnownSlotCount == -1) return; // No slots to draw


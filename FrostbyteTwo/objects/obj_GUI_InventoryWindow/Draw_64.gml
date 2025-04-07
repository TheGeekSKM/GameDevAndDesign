// Inherit the parent event
event_inherited();

if (!visible) return;
if (inventorySystemRef == undefined) return;
if (lastKnownSlotCount == -1) return; // No slots to draw


scribble("Right Click on Item for Item Actions")
    .align(fa_center, fa_top)
    .starting_format("VCR_OSD_Mono", c_white)
    .transform(0.5, 0.5, 0)
    .sdf_outline(c_black, 2)
    .draw(x, y + (sprite_height / 2) + 10);


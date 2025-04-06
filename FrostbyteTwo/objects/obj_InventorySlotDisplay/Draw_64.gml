// Inherit the parent event
event_inherited();

if (inventorySystemRef == undefined) return;
var slotData = inventorySystemRef.GetSlot(slotIndex);

var isDragSource = false;
if (global.dragData.isDragging && global.dragData.sourceInventory == inventorySystemRef && global.dragData.sourceSlotIndex == slotIndex) {
    isDragSource = true;
}
draw_self();


if (!isDragSource && slotData != undefined && slotData.item != undefined && slotData.quantity > 0)
{
    var item = slotData.item;
    var quantity = slotData.quantity;

    var spriteWidth = sprite_get_width(item.sprite);
    var spriteHeight = sprite_get_height(item.sprite);

    var drawX = x + (sprite_width / 2);
    var drawY = y + (sprite_height / 2);

    draw_sprite(item.sprite, 0, drawX, drawY);

    if (quantity > 1)
    {
        var textX = x + slotSize - 2;
        var textY = y + slotSize - 2;

        scribble($"{quantity}")
            .align(fa_right, fa_bottom)
            .starting_format("spr_OutlineFont", c_white)
            .transform(0.5, 0.5, 0)
            .draw(textX, textY);
    }

    if (equippedItem)
    {
        draw_sprite(spr_equippedIndicator, 0, x + (sprite_width / 2), y + sprite_height - 7);
    }
}
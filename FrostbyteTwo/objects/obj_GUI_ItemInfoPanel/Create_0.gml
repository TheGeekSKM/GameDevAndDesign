// Inherit the parent event
event_inherited();

currentSlotObject = noone;
currentScribble = undefined;
// menu opens when "ItemInfoClicked" event is triggered
Subscribe("ItemInfoClicked", function(_slotObject)
{
    currentSlotObject = _slotObject;
    endingPos = new Vector2(guiMouseX - (sprite_width / 2) - 10, guiMouseY - (sprite_height / 2) - 10);
    OpenMenu();

    var inventory = currentSlotObject.inventorySystemRef;
    var item = inventory.GetSlot(currentSlotObject.slotIndex).item;
    var infoTxt = item.GetDescription();

    currentScribble = scribble(infoTxt)
        .align(fa_left, fa_top)
        .starting_format("VCR_OSD_Mono", c_white)
        .transform(0.75, 0.75, 0)
        .sdf_outline(c_black, 2)

    var widthScale = (currentScribble.get_width() + 36) / sprite_get_width(sprite_index);
    var heightScale = (currentScribble.get_height() + 36) / sprite_get_height(sprite_index);

    image_xscale = widthScale;
    image_yscale = heightScale;

    Name = item.name;
});
// display info

// panel name needs to change to display item name
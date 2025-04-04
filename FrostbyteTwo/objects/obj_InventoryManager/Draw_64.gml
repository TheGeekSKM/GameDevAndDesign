if (global.dragData.isDragging && global.dragData.item != undefined) {
    var drawX = guiMouseX + global.dragData.mouseOffsetX;
    var drawY = guiMouseY + global.dragData.mouseOffsetY;
    var item = global.dragData.item;
    var quantity = global.dragData.quantity;

    draw_sprite(item.sprite, 0, drawX, drawY);

    if (quantity > 1)
    {
        var textX = drawX + sprite_get_width(item.sprite) - 2;
        var textY = drawY + sprite_get_height(item.sprite) - 2;
        scribble($"{quantity}")
            .align(fa_right, fa_bottom)
            .starting_format("spr_OutlineFont", c_white)
            .transform(0.5, 0.5, 0)
            .draw(textX, textY);
    }
}
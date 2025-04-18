if (!instance_exists(global.vars.Players[0])) return;
// Inherit the parent event
event_inherited();
if (!vis) return;

if (array_length(obj_Player1.inventory.allItems) == 0) {
    scribble("No Items in Inventory")
        .align(fa_left, fa_top)
        .starting_format("Font", c_black)
        .transform(0.75, 0.75, image_angle)
        .draw(topLeft.x + 13, topLeft.y + 28);
    return;
}

for (var i = 0; i < maxDisplay; i += 1) {
    var index = i + scrollOffset;
    if (index >= array_length(obj_Player1.inventory.allItems)) break;

    var yPos = topLeft.y + 28 + (i * 20);
    var xPos = topLeft.x + 13;
    var slot = obj_Player1.inventory.allItems[index];

    var txt = "";

    if (index == selectedIndex) 
    {
        
        txt = $"[{sprite_get_name(slot.item.sprite)}][c_yellow]> {slot.item.name} x{slot.quantity}{ slot.item.equipped ? " (Equipped)" : ""} <[/c]";
    }
    else
    {
        txt = $"[{sprite_get_name(slot.item.sprite)}] {slot.item.name} x{slot.quantity}{ slot.item.equipped ? " (Equipped)" : ""}";
    }

    scribble(txt)
        .align(fa_left, fa_top)
        .starting_format("Font", c_white)
        .transform(0.75, 0.75, image_angle)
        .draw(xPos, yPos);
}

// draw item info at 245, 28
selectedIndex = clamp(selectedIndex, 0, array_length(obj_Player1.inventory.allItems) - 1);
var slot = obj_Player1.inventory.allItems[selectedIndex];
var itemInfo = slot.item.GetDescription();
scribble(itemInfo)
    .align(fa_left, fa_top)
    .starting_format("Font", c_white)
    .transform(0.75, 0.75, image_angle)
    .wrap(95 / 0.75)
    .draw(topLeft.x + 245, topLeft.y + 28);



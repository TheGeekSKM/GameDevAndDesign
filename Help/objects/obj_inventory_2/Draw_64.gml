// Inherit the parent event
event_inherited();

for (var i = 0; i < array_length(obj_Player2.inventory.items); i++)
{
    var str = string_concat(obj_Player2.inventory.items[i].item.name, " x", obj_Player2.inventory.items[i].itemCount);
    if (selectIndex == i)
    {
        scribble(string_concat("> ", str, " <"))
            .align(fa_center, fa_middle)
            .starting_format("CustomFont", global.vars.playerColors[1])
            .transform(1, 1, image_angle)
            .sdf_outline(c_black, 2)
            .draw(x, y + (i * 40) + startingPos.y);    
    }
    else {
        scribble(str)
            .align(fa_center, fa_middle)
            .starting_format("CustomFont", c_white)
            .transform(1, 1, image_angle)
            .draw(x, y + (i * 40) + startingPos.y);
    }
}
if (array_length(obj_Player2.inventory.items) <= 0) return;
scribble(obj_Player2.inventory.items[selectIndex].item.description)
    .align(fa_center, fa_top)
    .starting_format("CustomFont", c_white)
    .transform(1, 1, image_angle)
    .wrap(213)
    .draw(x, y + startingYPos);
    
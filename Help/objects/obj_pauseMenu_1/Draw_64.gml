// Inherit the parent event
event_inherited();

for (var i = 0; i < array_length(buttons); i++)
{
    if (selectIndex == i)
    {
        scribble(string_concat("> ", buttons[i], " <"))
            .align(fa_center, fa_middle)
            .starting_format("CustomFont", global.vars.playerColors[0])
            .transform(1, 1, image_angle)
            .sdf_outline(c_black, 2)
            .draw(x + startingPos.x, y + (i * 40) + startingPos.y);
    }
    else 
    {
        scribble(string_concat(buttons[i]))
            .align(fa_center, fa_middle)
            .starting_format("CustomFont", c_white)
            .transform(1, 1, image_angle)        
            .draw(x + startingPos.x, y + (i * 40) + startingPos.y);        
    }
}
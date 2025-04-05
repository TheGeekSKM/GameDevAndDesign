for (var i = 1; i < array_length(spr); i++)
{
    if (currentState == ButtonState.Hover) 
    {
        Highlight(sprite_index, image_index, spr[i][0], spr[i][1], 1.2, 1.2, spr[i][2], global.vars.highlightColors[Type]);
    }
    draw_sprite_ext(sprite_index, image_index, spr[i][0], spr[i][1], 1, 1, spr[i][2], c_white, 1);
    
}
if (currentState == ButtonState.Hover) Highlight(sprite_index, image_index, x, y, 1.2, 1.2, image_angle, global.vars.highlightColors[Type]);
draw_self()
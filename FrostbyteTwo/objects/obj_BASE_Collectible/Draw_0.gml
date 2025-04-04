for (var i = 1; i < array_length(spr); i++)
{
    draw_sprite_ext(sprite_index, image_index, spr[i][0], spr[i][1], 1, 1, spr[i][2], c_white, 1);
    if (currentState == ButtonState.Hover) 
    {
        draw_sprite_ext(sprite_index, image_index, spr[i][0], spr[i][1], 1.2, 1.2, spr[i][2], global.vars.highlightColors[Type], 1);
    }
}
draw_self()
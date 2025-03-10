draw_self();

if (currentState == ButtonState.Hover)
{
    draw_sprite_ext(HighlightSprite, image_index, x, y, 
        image_xscale, image_yscale, image_angle, 
        global.vars.highlightColors[Type], 1
    );
}

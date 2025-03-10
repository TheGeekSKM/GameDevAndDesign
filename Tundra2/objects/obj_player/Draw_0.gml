draw_self();

if (currentState == ButtonState.Hover)
{
    draw_sprite_ext(HighlightSprite, image_index, x, y, 
        image_xscale, image_yscale, image_angle, 
        make_color_rgb(0, 255, 0), 1
    );
}
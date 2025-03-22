if (!obj_AttributeSelection_0.ready)
{
    draw_self();
    scribble(txt)
        .align(fa_left, fa_top)
        .starting_format("Font", c_white)
        .transform(0.5, 0.5, image_angle)
        .wrap(264 * 2)
        .draw(x - (sprite_width / 2) + 12, y - (sprite_height / 2) + 14);
}
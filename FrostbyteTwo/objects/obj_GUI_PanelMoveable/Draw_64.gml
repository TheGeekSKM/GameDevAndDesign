draw_self();


scribble(Name)
    .align(fa_center, fa_middle)
    .starting_format("spr_ShadowFont", c_white)
    .transform(1, 1, image_angle)
    .wrap(sprite_width - 36)
    .draw(x, y - (sprite_height / 2) + 18)


draw_self();

scribble(obj_PCManager.ToString())
    .align(fa_center, fa_middle)
    .starting_format("Font", c_black)
    .transform(0.75, 0.75, image_angle)
    .draw(x - (sprite_width / 2) + 200, y - (sprite_height / 2) + 207);

depth = -10;

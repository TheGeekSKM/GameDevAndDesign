// Inherit the parent event
event_inherited();

scribble($"[c_darkBlue]{txt}")
    .align(fa_left, fa_top)
    .starting_format("spr_NormalFont", c_white)
    .transform(0.75, 0.75, image_angle)
    .wrap(280 * 1.3333)
    .draw(x - (sprite_width / 2) + 18, y - (sprite_height / 2) + 24);

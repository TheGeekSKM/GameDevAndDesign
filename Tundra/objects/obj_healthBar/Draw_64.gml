draw_self();
draw_sprite_stretched_ext(spr_bar, 0, x + 10, y + 10, 180 * percentile, 16, col, 1);
draw_sprite(spr_barTop, 0, x, y);
scribble("Health Bar")
    .align(fa_left, fa_middle)
    .transform(1, 1, image_angle)
    .starting_format("VCR_OSD_Mono", col)
    .blend(col, hoverCounter / 60)
    .sdf_outline(c_black, 3)
    .draw(x + 210, y + (sprite_height / 2))
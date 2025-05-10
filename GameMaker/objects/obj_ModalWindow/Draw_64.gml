draw_self();
if (mouseOverClose)
{
    draw_sprite_ext(spr_pixel, 0, topRightX - 31, topRightY + 1, 30, 30, image_angle, c_red, 0.75);
}

scribble(title)
    .align(fa_left, fa_middle)
    .starting_format("VCR_OSD_Mono", c_black)
    .transform(1, 1, 0)
    .draw(topLeftX + 32, topLeftY + 16);

scribble($"{text}\n[c_grey][slant]You can press 'Enter' to close this...")
    .align(fa_left, fa_top)
    .starting_format("VCR_OSD_Mono", c_white)
    .transform(0.75, 0.75, 0)
    .wrap(285 * 1.3333)
    .draw(topLeftX + 5, topLeftY + 36);

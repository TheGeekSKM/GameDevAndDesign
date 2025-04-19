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

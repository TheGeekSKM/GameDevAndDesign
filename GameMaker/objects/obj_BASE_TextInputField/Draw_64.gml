if (GUI)
{
    draw_self();
    scribble($"> {text}")
        .align(fa_left, fa_middle)
        .starting_format("VCR_OSD_Mono", c_white)
        .transform(1, 1, image_angle)
        .draw(x - (sprite_width / 2) + 5, y)
}
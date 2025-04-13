draw_self();

scribble(Name)
    .align(fa_center, fa_middle)
    .starting_format("VCR_OSD_Mono", c_white)
    .transform(1.2, 1.2, image_angle)
    .sdf_outline(c_black, 3)
    .draw(x, y);
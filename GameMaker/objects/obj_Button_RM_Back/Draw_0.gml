draw_self();
scribble(Name)
        .align(fa_center, fa_middle)
        .starting_format("VCR_OSD_Mono", c_white)
        .transform(0.75, 0.75, image_angle)
        .wrap(((sprite_width) - 4) * 1.3333)
        .draw(x, y);
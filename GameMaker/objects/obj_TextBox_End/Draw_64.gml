draw_self();
scribble(text)
    .align(fa_center, fa_middle)
    .starting_format("VCR_OSD_Mono", c_white)
    .transform(0.8, 0.8, 0)
    .wrap(728)
    .draw(x, y);

scribble("[c_gold]The Game Is Done")
    .align(fa_left, fa_middle)
    .starting_format("VCR_OSD_Mono", c_white)
    .transform(1.2, 1.2, 0)
    .draw(16, 16);
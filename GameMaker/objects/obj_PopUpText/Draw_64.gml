scribble(textToDisplay)
    .align(fa_center, fa_middle)
    .starting_format("VCR_OSD_Mono", textColor)
    .blend(textColor, textAlpha)
    .transform(1.2, 1.2, 0)
    .sdf_outline(c_black, 2)
    .draw(x, y);
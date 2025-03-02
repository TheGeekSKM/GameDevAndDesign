scribble(text)
    .align(fa_center, fa_middle)
    .starting_format("CustomFont_Effects", c_white)
    .transform(5, 5, 0)
    .sdf_outline(c_black, 3)
    .sdf_shadow(c_black, .5, 0, 0, 10)
    .draw(x + 400, y + 224);
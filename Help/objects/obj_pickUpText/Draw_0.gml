scribble(textToDisplay)
    .align(fa_center, fa_middle)
    .starting_format("CustomFont", textColor)
    .blend(textColor, textAlpha)
    .transform(0.5, 0.5, 0)
    .sdf_outline(c_black, 2)
    .draw(x, y);
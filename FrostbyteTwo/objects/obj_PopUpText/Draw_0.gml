scribble(textToDisplay)
    .align(fa_center, fa_middle)
    .starting_format("spr_OutlineFont", textColor)
    .blend(textColor, textAlpha)
    .transform(0.5, 0.5, 0)
    .draw(x, y);
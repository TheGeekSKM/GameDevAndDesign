scribble(textToDisplay)
    .align(fa_center, fa_middle)
    .starting_format("VCR_OS_Mono", c_white)
    .blend(c_white, 1 - (fadeCounter / fadeTime))
    .draw(x, y);
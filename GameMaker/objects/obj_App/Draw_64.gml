if (currentState == ButtonState.Hover)
{
    scribble(Name)
        .align(fa_center, fa_middle)
        .starting_format("VCR_OSD_Mono", c_white)
        .transform(1, 1, 0)
        .draw(x, y + 32);
}

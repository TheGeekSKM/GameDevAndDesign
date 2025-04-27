if (GUI)
{
    scribble(Text)
        .align(fa_left, fa_middle)
        .starting_format("VCR_OSD_Mono", TextColor)
        .transform(1, 1, 0)
        .draw(x, y);
}
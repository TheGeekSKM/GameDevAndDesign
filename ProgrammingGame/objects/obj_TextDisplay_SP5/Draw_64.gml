if (GUI)
{
    scribble(Text)
        .align(fa_right, fa_top)
        .starting_format("VCR_OSD_Mono", TextColor)
        .transform(0.75, 0.75, 0)
        .wrap(500)
        .draw(x, y);
}
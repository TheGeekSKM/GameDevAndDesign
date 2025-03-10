if (drawSlide)
{
    draw_sprite_ext(spr_pixel, 0, 0, 0, 800, 448, 0, c_black, 1);
    scribble(slides[slideIndex])
        .align(fa_center, fa_middle)
        .starting_format("VCR_OSD_Mono", c_white)
        .transform(2, 2, 0)
        .draw(400, 224);
}
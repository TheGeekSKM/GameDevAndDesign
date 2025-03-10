draw_self();
var titlePos = new Vector2(x - 121, y - 159);

scribble(PanelTitle)
    .align(fa_left, fa_top)
    .starting_format("VCR_OSD_Mono", c_black)
    .transform(1, 1, image_angle)
    .draw(titlePos.x, titlePos.y);


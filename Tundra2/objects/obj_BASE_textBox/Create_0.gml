// Inherit the parent event
event_inherited();

txt = scribble(Text)
    .align(fa_center, fa_middle)
    .starting_format("VCR_OSD_Mono", c_black)
    .transform(0.75, 0.75, image_angle)
    .wrap(256)

bbox = txt.get_bbox(x, y);
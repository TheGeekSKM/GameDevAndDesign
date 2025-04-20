// Inherit the parent event
event_inherited();

draw_sprite(spr_TextDisplay_Foreground, 0, 0, 0);

scribble(title)
    .align(fa_left, fa_middle)
    .starting_format("VCR_OSD_Mono", c_white)
    .transform(1, 1, 0)
    .draw(100, 12)
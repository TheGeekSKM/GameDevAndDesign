// Inherit the parent event
event_inherited();

scribble_anim_wave(2, 0.75, 0.2);

scribble(speakerText)
    .align(fa_left, fa_top)
    .starting_format("VCR_OS_Mono", c_white)
    .transform(1, 1, image_angle)
    .wrap(705)
    .draw(x + 22, y + 22);


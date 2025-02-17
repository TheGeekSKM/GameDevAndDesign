// Inherit the parent event
event_inherited();
if (array_length(buttons) == 0) return;

scribble("Description")
    .align(fa_left, fa_top)
    .starting_format("VCR_OS_Mono_Effects", c_white)
    .transform(1.25, 1.25, image_angle)
    .draw(x + 22, y + 22);

scribble(buttons[selectedIndex].questDescription)
    .align(fa_left, fa_top)
    .starting_format("VCR_OS_Mono", c_white)
    .transform(0.75, 0.75, image_angle)
    .wrap(575)
    .draw(x + 22, y + 47);



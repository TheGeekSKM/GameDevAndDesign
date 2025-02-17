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
    .transform(1, 1, image_angle)
    .scale_to_box(575, 78)
    .draw(x + 22, y + 47);



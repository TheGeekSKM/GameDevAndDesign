// Inherit the parent event
event_inherited();
scribble(string_concat(speakerName, ": ", text))
    .align(fa_center, fa_middle)
    .starting_format("CustomFont", c_white)
    .transform(1, 1, image_angle)
    .wrap(sprite_width - 20)
    .draw(x, y);


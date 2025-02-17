// Inherit the parent event
event_inherited();

scribble(string_concat(obj_player.x, ", ", obj_player.y))
    .align(fa_center, fa_middle)
    .starting_format("VCR_OS_Mono", c_yellow)
    .draw(x, y);


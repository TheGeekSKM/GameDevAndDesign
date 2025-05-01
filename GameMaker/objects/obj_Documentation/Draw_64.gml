// Inherit the parent event
event_inherited();

draw_sprite(spr_documentationBackground, 0, 0, 0);


if (!atTop) draw_sprite_ext(spr_pointer, 0, x + (sprite_width / 2), y - 5, 0.75, 0.75, 90, c_white, 1);

if (!atBottom) draw_sprite_ext(spr_pointer, 0, x + (sprite_width / 2), y + (sprite_height) + 5, 0.75, -0.75, 270, c_white, 1);
    
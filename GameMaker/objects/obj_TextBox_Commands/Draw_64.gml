// Inherit the parent event
event_inherited();

draw_sprite(spr_CommandWindow_Foreground, 0, 0, 0);

if (!atTop) draw_sprite_ext(spr_ScrollNotif, 0, x, y - (sprite_height / 2) - 5, 0.75, 0.75, 0, c_white, 1);

if (!atBottom) draw_sprite_ext(spr_ScrollNotif, 0, x, y + (sprite_height / 2) + 5, 0.75, -0.75, 0, c_white, 1);


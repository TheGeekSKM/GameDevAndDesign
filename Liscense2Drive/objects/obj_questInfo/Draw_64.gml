// Inherit the parent event
event_inherited();

var _x = x + 45;
var _y = y + 45;

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_black);

draw_text_transformed(_x, _y, textToDisplay, 1, 1, image_angle);


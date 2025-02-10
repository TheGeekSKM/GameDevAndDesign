// Inherit the parent event
event_inherited();

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_black);
draw_set_font(Born);

var str = string_concat("Documents: ", global.Inventory);
draw_text_transformed(x, y, str, 2, 2, image_angle);


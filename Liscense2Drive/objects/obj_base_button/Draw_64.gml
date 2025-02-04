draw_self();

if (clicked) _y = y + 5;
else _y = y;

if (sprIcon != noone)
{
	draw_sprite(sprIcon, 0, x, y);
}

draw_set_color(c_black);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(Born);

draw_text_transformed(x, _y, text, 2, 2, 0);


draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
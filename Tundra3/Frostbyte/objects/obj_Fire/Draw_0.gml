
//draw radius of 50 pixels around the fire in a transparent orange color
draw_sprite(spr_fireBottom, 0, x, y + (sprite_width / 4));
draw_set_alpha(0.5);
draw_set_color(c_orange);
draw_circle(x, y, range, false);
draw_set_alpha(1);
draw_set_color(c_white);
draw_self();
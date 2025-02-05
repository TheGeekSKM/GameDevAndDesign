draw_self();

_y = y;

if (sprIcon != noone)
{
	draw_sprite(sprIcon, 0, x, y);
}

draw_set_color(c_black);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

font_enable_effects(Born_DropShadow, true, { 
    dropShadowEnable: true,
    dropShadowSoftness: 5,
    dropShadowOffsetX: 1,
    dropShadowOffsetY: 1,
    dropShadowAlpha: 0.3
    
})

if (mouseHover) {
    draw_set_font(Born_DropShadow);
    draw_text_transformed(x, _y + 4, text, 2, 2, 0);
}
else {
    draw_set_font(Born);
    draw_text_transformed(x, _y, text, 2, 2, 0);
}

draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
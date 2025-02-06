draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(textColor);

if (hovering) {
    image_index = 1;
    draw_set_font(Born_DropShadow);
    draw_text_transformed(x, y + 4, string_concat("> ", text , " <"), 2, 2, 0);
    image_blend = merge_color(image_blend, colorHover, 0.1);
}
else {
    image_index = 0;
    draw_set_font(Born);
    draw_text_transformed(x, y, text, 2, 2, 0);
    image_blend = merge_color(image_blend, colorIdle, 0.1);
}

if (clicked) {
    image_blend = colorClick;
}
    
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);

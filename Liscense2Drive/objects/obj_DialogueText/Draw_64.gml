// Inherit the parent event
event_inherited();

if (textToDisplay != "")
{
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_black);
    draw_set_font(Born);
    
    draw_text_transformed(x+ 30, y + 30, textToDisplay, 1, 1, image_angle);
}

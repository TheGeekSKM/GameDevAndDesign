// Inherit the parent event
event_inherited();

draw_set_valign(fa_middle);
draw_set_halign(fa_center);


switch (currentButtonState)
{
    case ButtonState.Idle:
        draw_set_font(VCR_OS_Mono);
        draw_set_color(textColor);
        draw_text_transformed(x, y - 8, text, 2, 2, image_angle);
        image_index = 0;
        break;
    case ButtonState.Hovered:
        draw_set_font(VCR_OS_Mono_Effects);
        draw_set_color(textColor);
        draw_text_transformed(x, y - 2, string_concat("> ", text, " <"), 2, 2, image_angle);
        image_index = 1;      
        break;
    case ButtonState.Clicked:
        draw_set_font(VCR_OS_Mono_Effects);
        draw_set_color(make_color_rgb(205, 205, 43));
        draw_text_transformed(x, y - 2, string_concat("> ", text, " <"), 2, 2, image_angle);
        image_index = 2;    
        break;        
}


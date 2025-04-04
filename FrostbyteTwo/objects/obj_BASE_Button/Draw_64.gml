draw_self();

switch (currentState)
{
    case ButtonState.Idle: 
        draw_set_font(global.NormalFont);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_set_color(c_black);
        draw_text(x, y, Text);
    break;
    
    case ButtonState.Hover: 
        draw_set_font(global.OutlineFont);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_set_color(ClickColor);
        draw_text(x, y + 2, Text);
        draw_set_color(c_black);
    break;
    
    case ButtonState.Click: 
        draw_set_font(global.OutlineFont);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_set_color(ClickColor);
        draw_text(x, y + 2, Text);
        draw_set_color(c_black);
    break;
}




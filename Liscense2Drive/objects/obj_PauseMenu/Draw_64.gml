// Inherit the parent event
event_inherited();

draw_set_valign(fa_middle);
draw_set_halign(fa_center);
draw_set_color(c_black);

switch(selectedIndex)
{
    case 0:
        draw_set_font(Born_DropShadow);
        draw_text_transformed(x, y - 50, string_concat("> ", options[0], " <"), 2, 2, 0);
        
        draw_set_font(Born);
        draw_text(x, y + 50, options[1]);
        
        break;
    case 1:
        draw_set_font(Born);
        draw_text(x, y - 50, options[0]);
        
        draw_set_font(Born_DropShadow);
        draw_text_transformed(x, y + 50, string_concat("> ", options[1], " <"), 2, 2, 0);
        
        break;
        
}


draw_set_valign(fa_top);
draw_set_halign(fa_left);
draw_set_color(c_white);



draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_font(Born_DropShadow);
draw_set_color(c_white);

if (global.TimeStruct.won)
{
    draw_text_transformed(x, y, string_concat("Previous Time: ", global.TimeStruct.realTime), 1, 1, 0);
    draw_text_transformed(x, y + 15, string_concat("Previous Time (Including Menus): ", global.TimeStruct.realTimeNoMenu), 0.75, 0.75, 0);
}
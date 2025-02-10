draw_set_halign(fa_left);
draw_set_valign(fa_bottom);
draw_set_font(Born_DropShadow);
draw_set_color(c_black);

global.TimeStruct.won = true;

draw_text_transformed(x, y, string_concat("You Won in: ", global.TimeStruct.realTime, " seconds!"), 2, 2, 0);
if (global.TimeStruct.realTime == global.TimeStruct.realTimeNoMenu)
{
    draw_text_transformed(x, y + 20, string_concat("You barely even looked at the menu UI :("), 1, 1, 0);
}
else {
    draw_text_transformed(x, y + 20, string_concat("Techincally ", global.TimeStruct.realTimeNoMenu, " seconds, if you count the time spent in menus..."), 1, 1, 0);
}

SaveGame();
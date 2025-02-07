draw_self();

var arrayLength = array_length(global.QuestLibrary);

if (arrayLength == 0)
{
	sprite_index = spr_noquests26;
}
else 
{
    sprite_index = questBoard;
}


for (var i = 0; i < (array_length(quests)); i++) 
{
    if (i == selectedIndex)
    {
        draw_set_color(c_teal);
        var stringToDisp = string_concat("> ", quests[i][$ "questName"], " <");
        draw_text_transformed(x + 40, y + 80 + (40 * i), stringToDisp, 2, 2, image_angle); 
    }
    else {
        draw_set_color(c_black);
        draw_text_transformed(x + 40, y + 80 + (40 * i), quests[i][$ "questName"], 1, 1, image_angle);
    }
}
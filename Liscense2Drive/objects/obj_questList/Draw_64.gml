draw_self();

var arrayLength = array_length(global.QuestLibrary);

if (arrayLength == 0)
{
	sprite_index = spr_noquests30;
}
else 
{
    sprite_index = questBoard;
}

var keyUp = keyboard_check_pressed(ord("W")) or keyboard_check_pressed(vk_up); 
var keyDown = keyboard_check_pressed(ord("S")) or keyboard_check_pressed(vk_down); 

if (vis)
{
    var diff = keyDown - keyUp;
    selectedIndex += diff;
    selectedIndex = loop(selectedIndex, 0, arrayLength - 1);
}


for (var i = 0; i < (array_length(quests)); i++) 
{
    if (quests[i][$ "questState"] == QuestState.Idle) return;
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
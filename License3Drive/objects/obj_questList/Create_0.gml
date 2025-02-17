vis = false;
buttons = [];
selectedIndex = 0;



function DrawGUI()
{
    var _x = x + sprite_width / 2;
    var _y = y + 88;
    
    for (var i = 0; i < array_length(buttons); i++) {
        if (i == selectedIndex)
        {
            scribble(string_concat("> ", buttons[i].questName, ConvertStateToString(buttons[i].questState), " <"))
                .align(fa_center, fa_middle)
                .transform(1.5, 1.5, image_angle)
                .starting_format("VCR_OS_Mono_Effects", buttons[i].questState == QuestState.Completed ? c_green : c_yellow)
                .sdf_shadow(c_black, 0.7, 0, 0, 0.2)
                .wrap(350)            
                .draw(_x, _y + (50 * i));
        }
        else {
            scribble(string_concat(buttons[i].questName))
                .align(fa_center, fa_middle)
                .transform(1, 1, image_angle)
                .starting_format("VCR_OS_Mono", c_white)
                .wrap(350)               
                .draw(_x, _y + (30 * i));
        }
    }    
}

function UpdateList() {
    if (array_length(buttons) != array_length(obj_player.QuestLibrary))
    {
        buttons = [];
        for (var i = 0; i < array_length(obj_player.QuestLibrary); i++)
        {
            array_push(buttons, obj_player.QuestLibrary[i]);
        }
    }
}
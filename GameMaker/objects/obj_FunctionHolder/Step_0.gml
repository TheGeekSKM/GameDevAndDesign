if (selected) image_blend = c_white;
else image_blend = c_gray;

if (functionScript == "") return;

if (!playerExists) return;
if (point_in_rectangle(guiMouseX, guiMouseY, x - (sprite_width / 2), y - (sprite_height / 2), x + (sprite_width / 2), y + (sprite_height / 2))) 
{
    if (!hovered) hovered = true;

    if (mouse_check_button_pressed(mb_left)) 
    {
        global.Interpreter.StartInterpreter(compiledCode);
    }
    else if (mouse_check_button_pressed(mb_right))
    {
        // open the code in a different window
        global.TextDisplay = functionScript;
        var str = {
            TextDisplay : functionScript
        }
        str = json_stringify(str);
        
        SafeWriteJson(game_save_id + "TextDisplay.json", str);
        
        CreateNewWindow(2);
        
    }
}
else if (hovered) 
{
    hovered = false;
}
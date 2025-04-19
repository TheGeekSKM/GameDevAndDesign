if (keyboard_check(vk_anykey) and string_length(text) < textCharLimit)
{
    text = string_concat(text, string(keyboard_string));
    keyboard_string = "";
}

if (keyboard_check(vk_backspace) && !keyboard_check_pressed(vk_backspace) && deleteTimer == 2)
{
    text = string_delete(text, string_length(text), 1);
    deleteTimer = 0;
    keyboard_string = "";
}


if (keyboard_check_pressed(vk_backspace))
{
    text = string_delete(text, string_length(text), 1)
    keyboard_string = "";
    deleteTimer = -4;
}

if (deleteTimer != 2) deleteTimer++;

if (keyboard_check_pressed(vk_enter)) EnterPressed();
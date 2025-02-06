var buttonNum = ds_list_size(__keyBoardButtons);

if (keyboard_check_pressed(ord("W")) or keyboard_check_pressed(vk_up)) {
    selectedIndex--;
    OnIndexUpdate(buttonNum - 1);
}
else if (keyboard_check_pressed(ord("S")) or keyboard_check_pressed(vk_down)) {
    selectedIndex++;
    OnIndexUpdate(buttonNum - 1);
}


if (keyboard_check_pressed(vk_enter)) {
    if (instance_exists(selectedButton)) {
        with (selectedButton) {
            OnClickStart();
        }
    }
}

if (keyboard_check_released(vk_enter)) {
    if (instance_exists(selectedButton)) {
        with (selectedButton) {
            OnClickEnd();
        }
    }
}


//show_debug_message(selectedIndex)
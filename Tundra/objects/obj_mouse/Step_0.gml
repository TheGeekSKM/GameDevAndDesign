x = device_mouse_x_to_gui(0);
y = device_mouse_y_to_gui(0);

if (mouse_check_button_pressed(mb_left)) Raise("LeftClick", currentState);

image_index = currentState;
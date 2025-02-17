if (!vis) return;

UpdateList();
if (array_length(buttons) == 0) return;

var movement = input_check_pressed("down") - input_check_pressed("up");
selectedIndex = mod_wrap(selectedIndex + movement, array_length(buttons));
var movement = input_check_pressed("right") - input_check_pressed("left");
if (movement != 0) { IncrementIndex(movement); }

if (input_check_pressed("accept")) { buttons[selectedIndex].OnClickStart(); }
else if (input_check_released("accept")) { buttons[selectedIndex].OnClickEnd(); }
    
oldIndex = selectedIndex;
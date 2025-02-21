var leftKey = false;
var rightKey = false;
var select = false;
var selectReleased = false;


if (checkForInput) {

	leftKey = keyboard_check_pressed(ord("A")) or keyboard_check_pressed(vk_left);
	rightKey = keyboard_check_pressed(ord("D")) or keyboard_check_pressed(vk_right);
	select = keyboard_check_pressed(ord("J"));
	selectReleased = keyboard_check_released(ord("J"));

}
var movement = rightKey - leftKey;
if (movement != 0) { IncrementIndex(movement); }

if (select) { buttons[selectedIndex].OnClickStart(); }
else if (selectReleased) { buttons[selectedIndex].OnClickEnd(); }
    
oldIndex = selectedIndex;
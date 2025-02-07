if (!vis) return;

var keyUp = keyboard_check_pressed(ord("W")) or keyboard_check_pressed(vk_up);
var keyDown = keyboard_check_pressed(ord("S")) or keyboard_check_pressed(vk_down);
var keyMovement = keyDown - keyUp;

var keyEnter = keyboard_check_pressed(vk_enter);

if (keyMovement != 0)
{
    selectedIndex += keyMovement;
    selectedIndex = loop(selectedIndex, 0, array_length(options) - 1);
}

if (keyEnter)
{
    functions[selectedIndex]();
}
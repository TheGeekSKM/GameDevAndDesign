var shiftHeld = keyboard_check(vk_lshift);
var ctrlHeld = keyboard_check((vk_lcontrol));
var movement = keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);

if (movement != 0 && shiftHeld)
{
    currentFunctionSlotIndex += movement;
    
    if (currentFunctionSlotIndex >= 3)
    {
        currentFunctionSlotIndex = 0;
    }
    else if (currentFunctionSlotIndex < 0)
    {
        currentFunctionSlotIndex = 2;
    }
    
    echo(currentFunctionSlotIndex);
    
    CurrentIndexUpdated();
}

if (keyboard_check_pressed(ord("E")) && shiftHeld && ctrlHeld)
{
    Raise("Compiled", currentFunctionSlot)
}
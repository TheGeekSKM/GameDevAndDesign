if (!vis) return;
    
var movement = keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);
var select = keyboard_check_pressed(vk_rcontrol);
var back = keyboard_check_pressed(vk_numpad0);

if (movement != 0)
{
    selectIndex = ModWrap(selectIndex + movement, array_length(obj_Player2.inventory.items));
}

if (back)
{
    Raise("InventoryClose", obj_Player2);
}
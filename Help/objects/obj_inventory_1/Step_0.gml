if (!vis) return;
    
var movement = keyboard_check_pressed(ord("S")) - keyboard_check_pressed(ord("S"));
var select = keyboard_check_pressed(ord("E"));
var back = keyboard_check_pressed(vk_lshift);

if (movement != 0)
{
    selectIndex = ModWrap(selectIndex + movement, array_length(obj_Player1.inventory.items));
}

if (back)
{
    Raise("InventoryClose", obj_Player1);
}
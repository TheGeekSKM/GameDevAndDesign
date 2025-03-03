if (!vis) return;
    
var movement = keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);
var select = keyboard_check_pressed(vk_rcontrol);
var back = keyboard_check_pressed(vk_numpad0);
var drop = keyboard_check_pressed(vk_rshift);

if (movement != 0)
{
    selectIndex = ModWrap(selectIndex + movement, array_length(obj_Player2.inventory.items));
}

if (back)
{
    Raise("InventoryClose", obj_Player2);
}


if (select)
{
    var item = obj_Player2.inventory.items[selectIndex].item
    obj_Player2.inventory.Consume(item);
}


if (drop and array_length(obj_Player2.inventory.items) > 0)
{
    var item = obj_Player2.inventory.items[selectIndex].item
    obj_Player2.inventory.DropItem(item, 1);
}
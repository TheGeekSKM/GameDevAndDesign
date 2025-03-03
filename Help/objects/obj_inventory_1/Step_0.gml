if (!vis) return;
    
var movement = keyboard_check_pressed(ord("S")) - keyboard_check_pressed(ord("W"));
var select = keyboard_check_pressed(ord("E"));
var back = keyboard_check_pressed(vk_lshift);
var drop = keyboard_check_pressed(ord("Q"));

if (movement != 0)
{
    selectIndex = ModWrap(selectIndex + movement, array_length(obj_Player1.inventory.items));
}

if (back)
{
    Raise("InventoryClose", obj_Player1);
}

if (select)
{
    var item = obj_Player1.inventory.items[selectIndex].item
    obj_Player1.inventory.Consume(item);
}

if (drop and array_length(obj_Player1.inventory.items) > 0)
{
    var item = obj_Player1.inventory.items[selectIndex].item
    obj_Player1.inventory.DropItem(item, 1);
}
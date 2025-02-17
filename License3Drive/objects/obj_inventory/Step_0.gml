if (!vis) return;

if (array_length(buttons) == 0) return;

if (input_check_pressed("accept") and array_length(buttons) > 0)
{
    for (var i = 0; i < array_length(buttons); i++) {
        if (i == selectedIndex)
        {
            buttons[selectedIndex].state = ItemState.Equipped;
            Raise("ItemEquipped", buttons[selectedIndex].name);
        }
        else {
            buttons[i].state = ItemState.Unequipped;            
            Raise("ItemUnequipped", buttons[i].name);            
        }
    }
}

var movement = input_check_pressed("down") - input_check_pressed("up");
selectedIndex = mod_wrap(selectedIndex + movement, array_length(buttons));

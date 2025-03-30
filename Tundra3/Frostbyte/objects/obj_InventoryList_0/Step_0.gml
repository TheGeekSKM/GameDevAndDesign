if (!instance_exists(global.vars.Players[0])) return;
if (!vis) return;
inventory = obj_Player1.inventory;
topLeft = new Vector2(x - (sprite_width / 2), y - (sprite_height / 2));

var up = global.vars.InputManager.IsPressed(PlayerIndex, ActionType.Up);
var down = global.vars.InputManager.IsPressed(PlayerIndex, ActionType.Down);
var select = keyboard_check_pressed(ord("E"));

if (up)
{
    selectedIndex = max(0, selectedIndex - 1);

    if (selectedIndex < scrollOffset)
    {
        scrollOffset = max(0, scrollOffset - 1);
    }
}

if (down)
{
    selectedIndex = min(array_length(inventory.allItems) - 1, selectedIndex + 1);

    if (selectedIndex >= scrollOffset + maxDisplay)
    {
        scrollOffset = min(array_length(inventory.allItems) - maxDisplay, scrollOffset + 1);
    }
}

var menu = global.vars.InputManager.IsPressed(PlayerIndex, ActionType.Menu);
if (menu)
{
    Raise("InventoryClose", PlayerIndex);
}

if (array_length(inventory.allItems) == 0) return;

if (select)
{
    echo("Player 1 pressed Select")
    obj_Player1.inventory.UseItemByIndex(selectedIndex, 1, PlayerIndex);
}

var drop = global.vars.InputManager.IsPressed(PlayerIndex, ActionType.Action2);
if (drop)
{
    obj_Player1.inventory.DropItemByIndex(selectedIndex, 1);
}


inventory = global.vars.Players[PlayerIndex].inventory;
topLeft = new Vector2(x - (sprite_width / 2), y - (sprite_height / 2));

var up = global.vars.InputManager.IsPressed(PlayerIndex, ActionType.Up);
var down = global.vars.InputManager.IsPressed(PlayerIndex, ActionType.Down);
var select = global.vars.InputManager.IsPressed(PlayerIndex, ActionType.Action1);

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

if (select)
{
    if (array_length(inventory.allItems) == 0) return;
    global.vars.Players[PlayerIndex].inventory.UseItemByIndex(selectedIndex, 1);
}
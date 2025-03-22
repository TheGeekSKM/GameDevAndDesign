// Inherit the parent event
event_inherited();
SetPlayerIndex(1);

maxDisplay = 5;
scrollOffset = 0;
selectedIndex = 0;

function DrawGUI()
{
    if (GetNumberOfCrafting() == 0)
    {
        scribble("No Recipes Found")
            .align(fa_center, fa_middle)
            .starting_format("Font", c_black)
            .sdf_shadow(c_black, 0.7, 0, 0, 20)
            .transform(2, 2, image_angle)
            .draw(x, y);
        return;
    }

    for (var i = 0; i < maxDisplay; i += 1)
    {
        var index = i + scrollOffset;
        if (index >= GetNumberOfCrafting()) break;

        var yPos = topLeft.y + 26 + (i * 22);
        var xPos = topLeft.x + 12;
        var recipe = GetCraftingByIndex(index);

        if (index == selectedIndex)
        {
            scribble($"[c_yellow]> {recipe.name} <[/c]")
                .align(fa_left, fa_top)
                .starting_format("Font", c_white)
                .sdf_outline(c_black, 2)
                .transform(0.75, 0.75, image_angle)
                .draw(xPos, yPos);
        }
        else
        {
            scribble($"{recipe.name}")
                .align(fa_left, fa_top)
                .starting_format("Font", c_black)
                .transform(0.75, 0.75, image_angle)
                .draw(xPos, yPos);
        }
    }

    //display recipe info starting at 183, 24 and wrap at 156 * (1 / textScale)
    var textScale = 0.75;
    var recipe = GetCraftingByIndex(selectedIndex);

    scribble(recipe.ToString())
        .align(fa_left, fa_top)
        .starting_format("Font", c_black)
        .transform(textScale, textScale, image_angle)
        .wrap(156 * (1 / textScale))
        .draw(topLeft.x + 183, topLeft.y + 24);

}
function Step()
{
    var up = global.vars.InputManager.IsPressed(playerIndex, ActionType.Up);
    var down = global.vars.InputManager.IsPressed(playerIndex, ActionType.Down);

    if (up)
    {
        selectedIndex = max(0, selectedIndex - 1);

        if (selectedIndex < scrollOffset)
        {
            scrollOffset = max(0, scrollOffset - 1);
        }

        Raise($"Player{playerIndex}CraftingSelected", selectedIndex);
    }

    if (down)
    {
        selectedIndex = min(GetNumberOfCrafting() - 1, selectedIndex + 1);

        if (selectedIndex >= scrollOffset + maxDisplay)
        {
            scrollOffset = min(GetNumberOfCrafting() - maxDisplay, scrollOffset + 1);
        }

        Raise($"Player{playerIndex}CraftingSelected", selectedIndex);
    }

    var select = global.vars.InputManager.IsPressed(playerIndex, ActionType.Action1);
    if (select)
    {
        if (GetNumberOfCrafting() == 0) return;
        var recipe = GetCraftingByIndex(selectedIndex);
        recipe.Craft(global.vars.Players[playerIndex]);
    }
}
// Inherit the parent event
event_inherited();
SetPlayerIndex(1);

maxDisplay = 5;
scrollOffset = 0;
selectedIndex = 0;


alarm[0] = 1;

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

        Raise($"Player{playerIndex}QuestSelected", selectedIndex);
    }

    if (down)
    {
        selectedIndex = min(GetNumberOfQuests() - 1, selectedIndex + 1);

        if (selectedIndex >= scrollOffset + maxDisplay)
        {
            scrollOffset = min(GetNumberOfQuests() - maxDisplay, scrollOffset + 1);
        }

        Raise($"Player{playerIndex}QuestSelected", selectedIndex);
    }
}

function DrawGUI()
{
    if (GetNumberOfQuests() == 0)
    {
        scribble("No Quests Available")
            .align(fa_center, fa_middle)
            .starting_format("Font", c_black)
            .transform(0.75, 0.75, image_angle)
            .draw(x, y);
        return;
    }

    for (var i = 0; i < maxDisplay; i += 1)
    {
        var index = i + scrollOffset;
        if (index >= GetNumberOfQuests()) break;

        var yPos = topLeft.y + 16 + (i * 22);
        var xPos = x;
        var quest = GetQuestByIndex(index);

        if (index == selectedIndex)
        {
            scribble($"[c_yellow]> {quest.name} <[/c]")
                .align(fa_center, fa_top)
                .starting_format("Font", c_white)
                .sdf_outline(c_black, 2)
                .transform(0.75, 0.75, image_angle)
                .draw(xPos, yPos);
        }
        else
        {
            scribble($"{quest.name}")
                .align(fa_center, fa_top)
                .starting_format("Font", c_white)
                .transform(0.75, 0.75, image_angle)
                .draw(xPos, yPos);
        }
    }
}
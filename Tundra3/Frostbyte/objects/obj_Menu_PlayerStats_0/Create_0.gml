// Inherit the parent event
event_inherited();
SetPlayerIndex(0);

function DrawGUI()
{
    if (!instance_exists(global.vars.Players[playerIndex])) return;
    // start writing stats at 14, 25 and wrap 330 * (1 / textScale)
    var textScale = 0.5;

    var txt = global.vars.Players[playerIndex].stats.ToString(playerIndex);

    scribble(txt)
        .align(fa_middle, fa_top)
        .starting_format("Font", c_white)
        .transform(textScale, textScale, image_angle)
        .sdf_outline(c_black, 1.5)
        .wrap(330 * (1 / textScale))
        .draw(x, topLeft.y + 25);
}

function Step()
{
    if (instance_exists(global.vars.Players[playerIndex]))
    if (!vis) return;
    var menu = global.vars.InputManager.IsPressed(playerIndex, ActionType.Menu);
    if (menu)
    {
        Raise("StatsClose", playerIndex);
    }
}

// Inherit the parent event
event_inherited();
SetPlayerIndex(1);

function DrawGUI()
{
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

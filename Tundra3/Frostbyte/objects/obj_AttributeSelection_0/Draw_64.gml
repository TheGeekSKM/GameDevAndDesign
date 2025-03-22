draw_self();
var txt = "";


var txt = string_concat(txt, $"Total Points: {totalPoints}\n\n");
switch (selectIndex)
{
    case 0: 
        txt = string_concat(txt, "> [c_yellow]Strength:[/c] ", str, " <\n");
        txt = string_concat(txt, "Dexterity: ", dex, "\n");
        txt = string_concat(txt, "Constitution: ", con, "\n");
    break;
    case 1: 
        txt = string_concat(txt, "Strength: ", str, "\n");
        txt = string_concat(txt, "> [c_yellow]Dexterity:[/c] ", dex, " <\n");
        txt = string_concat(txt, "Constitution: ", con, "\n");
    break;
    case 2: 
        txt = string_concat(txt, "Strength: ", str, "\n");
        txt = string_concat(txt, "Dexterity: ", dex, "\n");
        txt = string_concat(txt, "> [c_yellow]Constitution:[/c] ", con, " <\n");
    break;
}

scribble(txt)
    .align(fa_center, fa_middle)
    .starting_format("Font", c_white)
    .transform(1, 1, image_angle)
    .draw(x, y + 8);

if (ready)
{
    scribble("Ready!")
        .align(fa_center, fa_middle)
        .starting_format("Font", global.vars.PlayerColors[playerIndex])
        .sdf_outline(c_black, 2)
        .transform(2, 2, 45)
        .draw(x, y);
}
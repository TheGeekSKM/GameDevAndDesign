scribble(string_concat("Total Points: ", totalPoints))
    .align(fa_center, fa_top)
    .starting_format("CustomFont", c_white)
    .sdf_outline(c_black, 2)
    .draw(x, y);

if (selectIndex == 0)
{
    scribble(string_concat("> Constitution: ", conPoints, " <"))
        .align(fa_center, fa_top)
        .starting_format("CustomFont", global.vars.playerColors[1])
        .sdf_outline(c_black, 2)
        .draw(x, y + 30);
}
else {
    scribble(string_concat("Constitution: ", conPoints))
        .align(fa_center, fa_top)
        .starting_format("CustomFont", c_white)
        .sdf_outline(c_black, 2)
        .draw(x, y + 30);    
}

if (selectIndex == 1)
{
    scribble(string_concat("> Strength: ", strPoints, " <"))
        .align(fa_center, fa_top)
        .starting_format("CustomFont", global.vars.playerColors[1])
        .sdf_outline(c_black, 2)
        .draw(x, y + 60);
}
else {
    scribble(string_concat("Strength: ", strPoints))
        .align(fa_center, fa_top)
        .starting_format("CustomFont", c_white)
        .sdf_outline(c_black, 2)
        .draw(x, y + 60);    
}

if (selectIndex == 2)
{
    scribble(string_concat("> Dexterity: ", dexPoints, " <"))
        .align(fa_center, fa_top)
        .starting_format("CustomFont", global.vars.playerColors[1])
        .sdf_outline(c_black, 2)
        .draw(x, y + 90);
}
else {
    scribble(string_concat("Dexterity: ", dexPoints))
        .align(fa_center, fa_top)
        .starting_format("CustomFont", c_white)
        .sdf_outline(c_black, 2)
        .draw(x, y + 90);    
}

if (ready)
{
    scribble(string_concat("READY"))
        .align(fa_center, fa_top)
        .starting_format("CustomFont", global.vars.playerColors[1])
        .transform(2, 2, randAngle)
        .sdf_outline(c_black, 2)
        .draw(x, y);    
}
else {
    if (selectIndex == 0)
    {
        scribble(string_concat("INFO: Constitution increases your health!"))
            .align(fa_center, fa_top)
            .starting_format("CustomFont", global.vars.playerColors[1])
            .transform(1, 1, 0)
            .sdf_outline(c_black, 2)
            .wrap(150)        
            .draw(x, y + 120);
    }
    else if (selectIndex == 1)
    {
        scribble(string_concat("INFO: Strength increases the amount of damage you do on each shot!"))
            .align(fa_center, fa_top)
            .starting_format("CustomFont", global.vars.playerColors[1])
            .transform(1, 1, 0)
            .sdf_outline(c_black, 2)
            .wrap(150)        
            .draw(x, y + 120);
    }
    else if (selectIndex == 2)
    {
        scribble(string_concat("INFO: Dexterity increases your speed and your attack speed for each shot!"))
            .align(fa_center, fa_top)
            .starting_format("CustomFont", global.vars.playerColors[1])
            .transform(1, 1, 0)
            .sdf_outline(c_black, 2)
            .wrap(150)        
            .draw(x, y + 120);
    }        
}
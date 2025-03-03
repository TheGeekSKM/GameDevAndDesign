draw_self();

scribble(string_concat("Constitution: ", obj_Player2.attributes.Constitution))
    .align(fa_center, fa_middle)
    .starting_format("CustomFont", c_white)
    .transform(1, 1, image_angle)
    .draw(x, y + startingPos.y);

scribble(string_concat("Strength: ", obj_Player2.attributes.Strength))
    .align(fa_center, fa_middle)
    .starting_format("CustomFont", c_white)
    .transform(1, 1, image_angle)
    .draw(x, y + startingPos.y + 50);

scribble(string_concat("Dexterity: ", obj_Player2.attributes.Dexterity))
    .align(fa_center, fa_middle)
    .starting_format("CustomFont", c_white)
    .transform(1, 1, image_angle)
    .draw(x, y + startingPos.y + 100);
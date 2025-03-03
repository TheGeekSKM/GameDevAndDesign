event_inherited();

for (var i = 0; i < array_length(global.vars.questLibrary); i++)
{
    scribble(string_concat(global.vars.questLibrary[i].name))
        .align(fa_center, fa_middle)
        .starting_format("CustomFont", c_white)
        .transform(1, 1, image_angle)
        .draw(x, y);
}
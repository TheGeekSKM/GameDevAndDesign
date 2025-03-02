for (var i = 0; i < array_length(spr); i++)
{
    draw_sprite_ext(sprite_index, image_index, spr[i][0], spr[i][1], 1, 1, spr[i][2], c_white, 1);
}
draw_self();


//if (playerInRange != noone and currentItem != undefined)
//{
    //scribble(string_concat(currentItem.name, "\n", interactText))
        //.align(fa_center, fa_middle)
        //.starting_format("CustomFont", global.vars.playerColors[playerInRange.playerIndex])
        //.transform(0.75, 0.75, 0)
        //.draw(x, y - 5);
//}
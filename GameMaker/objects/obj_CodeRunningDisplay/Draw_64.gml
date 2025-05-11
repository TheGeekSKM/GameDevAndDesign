draw_self()

if (currentStruct != undefined)
{
    for (var i = 0; i < array_length(lineMapArray); i++) {
        var txt = lineMapArray[i];
        if (i == currentLine)
        {
            txt = string_concat(lineMapArray[i], "[c_player]<- Here")
        }
        
        scribble(txt)
            .align(fa_left, fa_top)
            .starting_format("VCR_OSD_Mono", c_white)
            .transform(0.5, 0.5, image_angle)
            .wrap(sprite_width * 2 - 20)
            .draw(x + 10, y + 10 + (i * 24 * 0.75));
    }
}
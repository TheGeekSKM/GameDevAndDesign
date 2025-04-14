text = "";
scribbleText = undefined;
xScale = 1
yScale = 1

function Init(_text)
{
    text = _text;
    scribbleText = scribble(text)
        .align(fa_center, fa_middle)
        .starting_format("VCR_OSD_Mono", global.vars.Colors.c_lightParchment)
        .transform(1, 1, image_angle)
        .sdf_outline(c_black, 2)
        .wrap(200)
    
    xScale = (scribbleText.get_width() + 64) / sprite_get_width(sprite_index);
    yScale = (scribbleText.get_height() + 20) / sprite_get_height(sprite_index);


    
}

depth = -50
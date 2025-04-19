// Inherit the parent event
event_inherited();

description = "";
scribleStruct = undefined;
function SetDescription(_string)
{
    description = _string;
    scribleStruct = scribble(_string)
        .align(fa_center, fa_middle)
        .starting_format("VCR_OSD_Mono", c_white)
        .transform(1, 1, image_angle)
        .wrap(500);
    
    var width = scribleStruct.get_width() + 34;
    var height = scribleStruct.get_height() + 32 + 31;
    image_xscale = width / sprite_get_width(sprite_index);
    image_yscale = height / sprite_get_height(sprite_index);

    echo(description)

}

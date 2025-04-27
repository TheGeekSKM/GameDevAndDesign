draw_self();
if (functionScript != "")
{
    scribble($"{Index + 1}")
        .align(fa_left, fa_top)
        .starting_format("VCR_OSD_Mono", c_yellow)
        .transform(1, 1, image_angle)
        .draw(x - (sprite_width / 2) + 3, y - (sprite_height / 2) + 3);
    
    scribble($"{functionName}")
        .align(fa_center, fa_middle)
        .starting_format("VCR_OSD_Mono", c_yellow)
        .transform(1, 1, image_angle)
        .draw(x, y);
}
else 
{
    scribble($"{Index + 1}")
        .align(fa_left, fa_top)
        .starting_format("VCR_OSD_Mono", c_gray)
        .transform(1, 1, image_angle)
        .draw(x - (sprite_width / 2) + 3, y - (sprite_height / 2) + 3)   
    
    scribble($"EMPTY")
        .align(fa_center, fa_middle)
        .starting_format("VCR_OSD_Mono", c_gray)
        .transform(1, 1, image_angle)
        .draw(x, y);     
}
if (GUI)
{
    draw_self();
    scribble($"> {text}")
        .align(fa_left, fa_middle)
        .starting_format("VCR_OSD_Mono", c_white)
        .transform(1, 1, image_angle)
        .draw(x - (sprite_width / 2) + 5, y)
    
    scribble($"Choose a Name for your Game: ")
            .align(fa_center, fa_bottom)
            .starting_format("VCR_OSD_Mono", c_white)
            .transform(1, 1, image_angle)
            .draw(x, y - (sprite_height / 2) - 4)
    
    scribble($"Current Chosen Name: {global.GameData.Name}")
                .align(fa_center, fa_top)
                .starting_format("VCR_OSD_Mono", c_white)
                .transform(1, 1, image_angle)
                .draw(x, y + (sprite_height / 2) + 4)
}
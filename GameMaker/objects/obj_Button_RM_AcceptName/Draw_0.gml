draw_self();

if (obj_Mouse.currentInteractable == id) 
{
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_yellow, 1);
    
    scribble(Name)
        .align(fa_center, fa_middle)
        .starting_format("VCR_OSD_Mono", c_yellow)
        .transform(0.75, 0.75, image_angle)
        .wrap(((sprite_width) - 4) * 1.3333)
        .draw(x, y);
}
else {
    scribble(Name)
        .align(fa_center, fa_middle)
        .starting_format("VCR_OSD_Mono", c_white)
        .transform(0.75, 0.75, image_angle)
        .wrap(((sprite_width) - 4) * 1.3333)
        .draw(x, y);
}

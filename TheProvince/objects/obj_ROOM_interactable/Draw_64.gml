if (currentState == ButtonState.Hover)
{
    scribble($"{Name}\n{InteractText}")
        .align(fa_center, fa_bottom)
        .starting_format("VCR_OSD_Mono", c_white)
        .sdf_outline(c_black, 2)
        .transform(0.75, 0.75, image_angle)
        .draw(x, y - (sprite_height / 2) - 10)
}
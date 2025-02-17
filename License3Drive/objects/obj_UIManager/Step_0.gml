if (drawBlackBackground)
{
    with (obj_ui_pixel)
    {
        image_alpha = lerp(image_alpha, 0.75, 0.1);
    }
}
else 
{
    with (obj_ui_pixel)
    {
        image_alpha = lerp(image_alpha, 0, 0.1);
    }    
}
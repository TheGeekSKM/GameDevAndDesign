draw_self();
if (canDisplay) 
{
    image_alpha = lerp(image_alpha, 1, 0.1);
    counter++;
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    
    draw_text(x + 90, y + 10, textToDisplay);
    
    draw_set_valign(fa_top);
    
    if (counter >= (timeToDisplay * 60))
    {
        canDisplay = false;
    }
}
else 
{
    image_alpha = lerp(image_alpha, 0, 0.1);   
}
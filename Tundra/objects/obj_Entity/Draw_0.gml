draw_self();

if (mouseOver) { 
    draw_sprite_ext(HighlightSprite, image_index, x, y, image_xscale, image_yscale, 
        image_angle, hoverColor, 1) 
}

image_yscale = maxHeight / sprite_get_height(sprite_index);
image_xscale = maxWidth / sprite_get_width(sprite_index);


healthBarMinX = x + 2;
healthBarMaxX = x + maxWidth - 2;

healthBarMinY = y + 2;
healthBarMaxY = y + maxHeight - 2;

xScale = lerp(xScale, currentBarXScale, 0.1);
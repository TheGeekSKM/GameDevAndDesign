if (y > room_height or y < 0) instance_destroy();
image_xscale = lerp(image_xscale, scale, 0.1)    
image_yscale = lerp(image_yscale, scale, 0.1)    
    
scaleCounter++;

image_alpha = 1 - (scaleCounter / scaleTime);
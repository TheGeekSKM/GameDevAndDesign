text = scribble(textToDisplay)
    .align(fa_center, fa_middle)
    .starting_format("Font", c_black)
    .transform(0.7, 0.7, image_angle);

bbox = text.get_bbox(x, y);
xScale = (bbox.width + 32) / sprite_width;
yScale = (bbox.height + 8) / sprite_height;

depth = -50


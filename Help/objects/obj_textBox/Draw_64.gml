var text = scribble(textToDisplay)
    .align(fa_center, fa_middle)
    .starting_format("CustomFont", c_white)
    .transform(scale, scale, image_angle);

var bbox = text.get_bbox(x, y);
var xScale = (bbox.width + 12) / sprite_width;
var yScale = (bbox.height + 3) / sprite_height;

draw_sprite_ext(sprite_index, 0, x, y, xScale, yScale, image_angle, c_white, 1);

text.draw(x, y);
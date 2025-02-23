var txt = scribble(textToDisplay)
    .align(fa_center, fa_middle)
    .starting_format("VCR_OS_Mono", c_yellow)
    .transform(1, 1, image_angle)
    .wrap(240);

var bbox = txt.get_bbox(x, y);
var xScale = (bbox.width + 10) / sprite_width;
var yScale = (bbox.height + 2) / sprite_height;

draw_sprite_ext(spr_textBox, 0, bbox.x, bbox.y, xScale, 1, image_angle, c_white, 1);

txt.draw(x, y);







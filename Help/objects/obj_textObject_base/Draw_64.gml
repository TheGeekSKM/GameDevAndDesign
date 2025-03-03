var _text = scribble(text)
    .align(fa_center, fa_middle)
    .transform(1, 1, image_angle)
    .starting_format("CustomFont", c_white)
    .sdf_outline(c_black, 2);

var bbox = _text.get_bbox(x, y);
var xScale = (bbox.width + 12) / sprite_width;
var yScale = (bbox.height + 6) / sprite_height;

draw_sprite_ext(sprite_index, 0, x, y, xScale, yScale, image_angle, global.vars.playerColors[playerIndex], 1);

_text.draw(x, y);

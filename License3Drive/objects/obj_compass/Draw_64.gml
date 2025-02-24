//// Inherit the parent event
//event_inherited();
//
//scribble(string_concat(obj_player.x, ", ", obj_player.y))
    //.align(fa_center, fa_middle)
    //.starting_format("VCR_OS_Mono", c_yellow)
    //.draw(x, y);
if (!vis) return;

var playerGUICoords = RoomToGUICoords(obj_player.x, obj_player.y);

var text = scribble(string_concat("(", obj_player.x, ", ", obj_player.y, ")"))
    .align(fa_center, fa_middle)
    .starting_format("VCR_OS_Mono", c_white)
    .transform(1, 1, 0);

var bbox = text.get_bbox(playerGUICoords.x, playerGUICoords.y);
var xScale = (bbox.width + 10) / sprite_width;
var yScale = (bbox.height + 2) / sprite_height;

draw_sprite_ext(spr_textBox, 0, playerGUICoords.x, playerGUICoords.y - 50, xScale, yScale, 0, c_white, 1);

text.draw(playerGUICoords.x, playerGUICoords.y - 50);



if (!instance_exists(global.vars.Player)) return;

var coords = RoomToGUICoords(global.vars.Player.x, global.vars.Player.y);

draw_sprite_ext(sprite_index, 0, coords.x, coords.y, 1, 1, 0, c_white, obj_TimeManager.alphaValue);
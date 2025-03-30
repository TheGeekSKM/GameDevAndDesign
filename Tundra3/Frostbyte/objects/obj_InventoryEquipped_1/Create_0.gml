if (!instance_exists(global.vars.Players[1])) return;

topLeft = new Vector2(x - (sprite_width / 2), y - (sprite_height / 2));
image_blend = global.vars.PlayerColors[1];
inventory = obj_Player2.inventory;

depth = Depth;
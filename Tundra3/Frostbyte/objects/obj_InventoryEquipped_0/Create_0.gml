if (!instance_exists(global.vars.Players[0])) return;
vis = false;
topLeft = new Vector2(x - (sprite_width / 2), y - (sprite_height / 2));
image_blend = global.vars.PlayerColors[0];

depth = Depth;
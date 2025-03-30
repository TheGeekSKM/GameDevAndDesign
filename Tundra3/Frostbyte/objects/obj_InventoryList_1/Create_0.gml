if (!instance_exists(global.vars.Players[1])) return;
vis = false;
topLeft = new Vector2(x - (sprite_width / 2), y - (sprite_height / 2));
image_blend = global.vars.PlayerColors[PlayerIndex];
inventory = obj_Player2.inventory;

maxDisplay = 6;
scrollOffset = 0;
selectedIndex = 0;
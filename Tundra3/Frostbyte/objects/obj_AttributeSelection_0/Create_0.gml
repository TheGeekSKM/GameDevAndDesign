topLeft = new Vector2(x - (sprite_width / 2), y - (sprite_height / 2));
ready = false;
stats = new StatSystem(1, 1, 1, id);
playerIndex = 0;
image_blend = global.vars.PlayerColors[playerIndex];
selectIndex = 0;

totalPoints = 12;

str = 2;
dex = 2;
con = 2;

scribble_font_set_default("Font");

alarm[0] = 10;
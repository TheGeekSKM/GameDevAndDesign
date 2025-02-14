draw_self();

if (!global.debug) return;
if (checkForCars) draw_rectangle(x + (sprite_width / 2), y + (sprite_width / 2), nextX, nextY, true);
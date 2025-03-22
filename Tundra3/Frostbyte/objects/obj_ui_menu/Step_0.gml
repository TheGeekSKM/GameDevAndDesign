topLeft = new Vector2(x - (sprite_width / 2), y - (sprite_height / 2));

if (keyboard_check_pressed(vk_period)) vis = !vis;

if (!vis) return;
Step();
// Inherit the parent event
event_inherited();

if (!instance_exists(obj_Player1)) return;

global.vars.Players[playerIndex].entityHealth.Draw(180, 18, x + 9, y + 4, c_green, c_dkgray);
global.vars.Players[playerIndex].stamina.Draw(113, 14, x + 6, y + 28, c_yellow, c_dkgray);
global.vars.Players[playerIndex].temperature.Draw(113, 14, x + 6, y + 48, c_blue, c_dkgray);
global.vars.Players[playerIndex].hunger.Draw(113, 14, x + 6, y + 68, c_red, c_dkgray);

draw_sprite(spr_HUD_Top, 0, x, y);

scribble($"{obj_Player1.x}, {obj_Player1.y}")
    .align(fa_left, fa_middle)
    .starting_format("Font", global.vars.PlayerColors[playerIndex])
    .sdf_outline(c_black, 2)
    .transform(1, 1, 0)
    .draw(x + 200, y + 13);


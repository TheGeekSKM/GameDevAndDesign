
if (!instance_exists(global.vars.Player)) return;
draw_self();

global.vars.Player.entityHealth.Draw(180, 18, x + 9, y + 4, healthBarMainColor, healthBarUnderColor);
global.vars.Player.stamina.Draw(113, 14, x + 6, y + 28, staminaBarMainColor, staminaBarUnderColor);
global.vars.Player.temperature.Draw(113, 14, x + 6, y + 48, tempBarMainColor, tempBarUnderColor);
global.vars.Player.hunger.Draw(113, 14, x + 6, y + 68, hungerBarMainColor, hungerBarUnderColor);

draw_sprite(spr_HUD_Top, 0, x, y);

scribble($"{global.vars.Player.x}, {global.vars.Player.y}")
    .align(fa_left, fa_middle)
    .starting_format("VCR_OSD_Mono", c_white)
    .sdf_outline(c_black, 2)
    .transform(1, 1, 0)
    .draw(x + 200, y + 13);
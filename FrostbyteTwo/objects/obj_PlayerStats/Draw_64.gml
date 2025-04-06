// Inherit the parent event
event_inherited();

var txt = "";
if (instance_exists(global.vars.Player))
{
    txt = global.vars.Player.stats.ToString();
}

scribble(txt)
        .align(fa_middle, fa_top)
        .starting_format("VCR_OSD_Mono", c_white)
        .transform(textScale, textScale, image_angle)
        .sdf_outline(c_black, 1.5)
        .wrap(330 * (1 / textScale))
        .draw(x, topLeft.y + 36);

for (var i = 0; i < array_length(drawnGears); i++) {
    draw_sprite_ext(spr_gear, 0, drawnGears[i][0], drawnGears[i][1], 1, 1, drawnGears[i][2], c_white, 1);
}

if (global.debug)
{
    for (var i = 0; i < array_length(drawnGearsDebug); i++) {
        draw_rectangle_color(drawnGearsDebug[i][0], drawnGearsDebug[i][1], drawnGearsDebug[i][2], drawnGearsDebug[i][3], c_yellow, c_yellow, c_yellow, c_yellow, true);
    }
}

draw_self();

if (global.debug)
{
    draw_circle_color(x, y, interactionRange, c_yellow, c_yellow, true);
}
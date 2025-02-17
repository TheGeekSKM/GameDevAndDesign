for (var i = 1; i < array_length(drawnPapers); i++) {
    draw_sprite_ext(spr_paper, 0, drawnPapers[i][0], drawnPapers[i][1], 1, 1, drawnPapers[i][2], c_white, 1);
}

draw_self();

if (global.debug)
{
    draw_circle_color(x, y, interactionRange, c_yellow, c_yellow, true);
}
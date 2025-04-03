
draw_sprite_ext(spr_npc147, image_index, x, y, 1, 1, image_angle, make_color_rgb(70, 190, 94), 1);

if (currentState == ButtonState.Hover) 
{
    draw_sprite_ext(spr_humanHighlight, image_index, x, y, 1, 1, image_angle, c_green, 1);
}

if (rightClickHold) {
    draw_sprite(spr_target, attackIndex, mouse_x, mouse_y);
}
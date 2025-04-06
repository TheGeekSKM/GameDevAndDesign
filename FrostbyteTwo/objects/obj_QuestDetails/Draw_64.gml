draw_self();

if (quest != undefined) {
    scribble($"{quest.description}")
        .align(fa_left, fa_top)
        .starting_format("VCR_OSD_Mono", make_color_rgb(255, 170, 94))
        .transform(0.75, 0.75, image_angle)
        .wrap(158 * 1.3333)
        .draw(topLeft.x + 21, topLeft.y + 35);
}



draw_sprite(spr_questDetailsTop163, 0, topLeft.x, topLeft.y);

scribble(Name)
    .align(fa_center, fa_middle)
    .starting_format("spr_ShadowFont", c_white)
    .transform(1, 1, image_angle)
    .wrap(sprite_width - 36)
    .draw(x, y - (sprite_height / 2) + 18)
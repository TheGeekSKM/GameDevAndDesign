var text = scribble(global.textDisplay)
    .align(fa_center, fa_middle)
    .starting_format("VCR_OSD_Mono", global.vars.Colors.c_lightParchment)
    .transform(0.75, 0.75, image_angle)
    .wrap(400);

var widthScale = text.get_width() / sprite_get_width(spr_button2);
var heightScale = text.get_height() / sprite_get_height(spr_button2);

draw_sprite_ext(spr_button3, 0, x, y, widthScale, heightScale, 0, c_white, 1);

text.draw(x, y, typist);
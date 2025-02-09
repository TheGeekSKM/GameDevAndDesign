// Inherit the parent event
event_inherited();

if (speakingSprite == noone || speakingSprite == undefined) return;
draw_sprite_ext(speakingSprite, 0, x + _x, y + _y, 1, 1, image_angle, c_white, 1);



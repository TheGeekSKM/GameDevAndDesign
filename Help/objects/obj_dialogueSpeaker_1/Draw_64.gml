// Inherit the parent event
event_inherited();
if (speaker == noone) return;
draw_sprite_ext(spr_npc_Speaekr, 0, x, y, 1, 1, image_angle, speaker.npcColor, 1);


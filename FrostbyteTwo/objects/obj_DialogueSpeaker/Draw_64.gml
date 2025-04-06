// Inherit the parent event
event_inherited();

if (currentDialogueLine == undefined) {
    return;
}

draw_sprite_ext(spr_NPCSpeaker, currentIndex, x, y, 1, 1, image_angle, currentDialogueLine.speakerData.speakerColor, 1);

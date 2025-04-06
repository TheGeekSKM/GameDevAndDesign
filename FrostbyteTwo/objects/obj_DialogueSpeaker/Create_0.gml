// Inherit the parent event
event_inherited();

desiredWidthScale = (sprite_get_width(spr_NPCSpeaker) + 36) / sprite_get_width(sprite_index);
image_xscale = desiredWidthScale;
image_yscale = desiredWidthScale;

currentDialogueLine = undefined;
currentIndex = 0;


Subscribe("DialogueDisplay", function(_dialogueLine) {
    currentDialogueLine = _dialogueLine;
    currentIndex = irandom_range(0, 2);
});
